//
//  AuthorizedModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 17/07/2024.
//

import SwiftUI
import SwiftData

///maybe we dont need this 
final class UserProfileModel:ObservableObject{
    private let localStorage: LocalStorage
    private let api: API
    
    let query:Query<UserProfile,[UserProfile]>
    @MainActor var items :[UserProfile] {
        get {query.wrappedValue}
        set {}
    }
    init(localStorage: LocalStorage, api: API) {
        self.localStorage = localStorage
        self.api = api
        self.query = Query(sort: [
            .init(\.userId, order: .reverse)
        ], animation: .smooth)
    }
    
    func loadContent() async throws {
        do {
            try await api.fetchUsers()
        }catch{
            throw error
        }
    }
}
