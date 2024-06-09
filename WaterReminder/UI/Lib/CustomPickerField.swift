//
//  CustomPickerField.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 04/11/1445 AH.
//

import SwiftUI


struct CustomPickerField<SelectionValue: Hashable, Options: View>: View {
    @Binding var selection: SelectionValue
    var label: String
    var leadingIcon: Image
    var options: Options
    
    init(selection: Binding<SelectionValue>, label: String, leadingIcon: Image, @ViewBuilder options: @escaping () -> Options) {
        self._selection = selection
        self.label = label
        self.leadingIcon = leadingIcon
        self.options = options()
    }
    
    var body: some View {
        HStack(spacing: -10) {
            leadingIcon
                .font(.callout)
                .foregroundColor(.pointer)
                .frame(width: 40 ,alignment: .leading)
                .accessibility(hidden: true)
            
            Text(label)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Picker(label, selection: $selection) {
                options
            }
            .pickerStyle(.menu)
            .foregroundColor(.secondary)
            .font(.headline)
            .accessibilityLabel(label)
            .labelsHidden()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.pointer.opacity(0.06))
            
        }
        
    }
}
