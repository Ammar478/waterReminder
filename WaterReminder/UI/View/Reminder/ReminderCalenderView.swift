import SwiftUI
import UserNotifications

struct ReminderView: View {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var notificationManager = NotificationLocalManager()

    @State private var selectedDays: [String: Bool] = {
        let days = Calendar.current.shortWeekdaySymbols
        return Dictionary(uniqueKeysWithValues: days.map { ($0, false) })
    }()
    @State private var reminderTimes: [DateComponents] = {
        (6...22).filter { $0 % 2 == 0 }.map { hour in
            DateComponents(hour: hour, minute: 0)
        }
    }()
    @State private var enabledReminders: [Bool] = Array(repeating: true, count: 9)
    @State private var editingTimeIndex: Int? = nil
    @State private var allDaysSelected: Bool = false

    private let columns = [GridItem(.flexible())]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if notificationManager.isGranted {
                    headerView
                    daySelectionView
                    timePickersView
                } else {
                    EnableNotificationsView()
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.pointer.opacity(0.3), .clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .onChange(of: scenePhase) { newPhase, _ in
                if newPhase == .active {
                    Task {
                        await notificationManager.getCurrentSetting()
                    }
                }
            }
            .onChange(of: selectedDays) {
                scheduleReminders()
            }
            .onChange(of: reminderTimes) {
                scheduleReminders()
            }
            .onChange(of: enabledReminders) {
                scheduleReminders()
            }
            .navigationBarHidden(true)
        }

    }

    private var headerView: some View {
        Text("Set Reminders")
            .font(.largeTitle)
            .bold()
            .padding(.top)
    }

    private var daySelectionView: some View {
        VStack(spacing: 10) {
            Text("Select days for reminders")
                .font(.headline)

            Toggle(isOn: $allDaysSelected) {
                Text("All Days")
                    .font(.headline)
            }
            .toggleStyle(SwitchToggleStyle(tint: .pointer))
            .padding(.horizontal)
            .onChange(of: allDaysSelected) { newValue, _ in
                for day in selectedDays.keys {
                    selectedDays[day] = newValue
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 10) {
                    ForEach(selectedDays.keys.sorted(), id: \.self) { day in
                        dayToggle(day: day)
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func dayToggle(day: String) -> some View {
        Toggle(isOn: Binding(
            get: { selectedDays[day] ?? false },
            set: { selectedDays[day] = $0 }
        )) {
            Text(day.prefix(3))
                .font(.subheadline)
                .frame(width: 40, height: 40)
                .background(selectedDays[day] ?? false ? Color.pointer : Color.pointer.opacity(0.2))
                .cornerRadius(20)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                .scaleEffect(selectedDays[day] ?? false ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: selectedDays[day])
        }
        .toggleStyle(.button)
    }

    private var timePickersView: some View {
        ScrollView {
            ForEach(reminderTimes.indices, id: \.self) { index in
                timePickerRow(index: index)
            }
        }
    }

    private func timePickerRow(index: Int) -> some View {
        VStack {
            HStack {
                Text(formattedTime(reminderTimes[index]))
                    .font(.callout)
                    .padding(.leading)
                    .bold()
                    .foregroundStyle(.p1)
                    .onTapGesture {
                        withAnimation {
                            editingTimeIndex = index
                        }
                    }

                Spacer()

                Toggle(isOn: $enabledReminders[index]) {
                    Text("")
                }
                .toggleStyle(SwitchToggleStyle(tint: .pointer))
                .padding(.trailing)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: .pointer.opacity(0.1), radius: 2, x: 0, y: 2)
            .padding(.horizontal)
            .padding(.vertical, 2)
            .scaleEffect(enabledReminders[index] ? 1.0 : 0.95)
            .animation(.easeInOut(duration: 0.2), value: enabledReminders[index])

            if editingTimeIndex == index {
                timePickerEditor(index: index)
            }
        }
    }

    private func timePickerEditor(index: Int) -> some View {
        VStack {
            DatePicker(
                "Select Time",
                selection: Binding(
                    get: {
                        Calendar.current.date(from: reminderTimes[index]) ?? Date()
                    },
                    set: {
                        reminderTimes[index] = Calendar.current.dateComponents([.hour, .minute], from: $0)
                    }
                ),
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .cornerRadius(10)
            .padding(.horizontal)
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            .animation(.easeInOut(duration: 0.3), value: editingTimeIndex)

            Button(action: {
                withAnimation {
                    editingTimeIndex = nil
                }
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.pointer)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.3), value: editingTimeIndex)
    }

    private func scheduleReminders() {
        let daysOfWeek = ["Sun": 1, "Mon": 2, "Tue": 3, "Wed": 4, "Thu": 5, "Fri": 6, "Sat": 7]

        for (day, isSelected) in selectedDays where isSelected {
            guard let weekday = daysOfWeek[day.prefix(3).capitalized] else { continue }

            for (index, time) in reminderTimes.enumerated() where enabledReminders[index] {
                var dateComponents = time
                dateComponents.weekday = weekday

                let localNotification = LocalNotification(
                    identifier: UUID().uuidString,
                    title: "Reminder",
                    body: "It's time to drink water!",
                    timeInterval: nil,
                    dateComponents: dateComponents,
                    repeats: true
                )

                Task {
                    await notificationManager.schedule(localNotification: localNotification)
                }
            }
        }
    }

    private func formattedTime(_ components: DateComponents) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        guard let date = Calendar.current.date(from: components) else { return "" }
        return formatter.string(from: date)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
