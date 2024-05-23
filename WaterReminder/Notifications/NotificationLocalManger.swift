//
//  NotificationLocalManger.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 10/11/1445 AH.
//

import Foundation
import NotificationCenter
import UIKit

@MainActor
class NotificationLocalManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted = false
    @Published var pendingRequests: [UNNotificationRequest] = []

    override init() {
        super.init()
        notificationCenter.delegate = self
        
        Task{
            await getCurrentSetting()
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        await getPendingRequests()
        return [.sound, .banner]
    }

    func requestAuthorization() async {
        let options: UNAuthorizationOptions = [.sound, .badge, .alert]
        do {
            try await notificationCenter.requestAuthorization(options: options)
        } catch {
            print("Authorization request failed: \(error.localizedDescription)")
        }
        await getCurrentSetting()
    }

    func getCurrentSetting() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }

    func openSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }

    func schedule(localNotification: LocalNotification) async {
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.body = localNotification.body
        content.sound = .default

        var trigger: UNNotificationTrigger?

        if let dateComponents = localNotification.dateComponents {
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: localNotification.repeats)
        }

        guard let notificationTrigger = trigger else { return }

        let request = UNNotificationRequest(identifier: localNotification.identifier, content: content, trigger: notificationTrigger)

        do {
            try await notificationCenter.add(request)
            await getPendingRequests()
        } catch {
            print("Error adding notification: \(error.localizedDescription)")
        }
    }

    func getPendingRequests() async {
        pendingRequests = await notificationCenter.pendingNotificationRequests()
    }
}
