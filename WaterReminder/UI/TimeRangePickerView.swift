//
//  TimeRangePickerView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 05/11/1445 AH.
//

import SwiftUI

struct TimeRangePickerView: View {
    @Binding var value:TimeRange
    var body: some View {
        Picker(selection: $value.animation(.easeInOut), label: EmptyView()) {
            Text("7 Days").tag(TimeRange.lastWeek)
            Text("30 Days").tag(TimeRange.last30Days)
            Text("12 Months").tag(TimeRange.last12Months)
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    TimeRangePickerView(value: .constant(.lastWeek))
}
