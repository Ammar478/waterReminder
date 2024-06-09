//
//  CustomInputField.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 04/11/1445 AH.
//

import SwiftUI

struct CustomInputField:View {
    @Binding var text:String
    var hint:String
    var leadingIcon:Image
    var body: some View{
        HStack(spacing:-10){
            leadingIcon
                .font(.callout)
                .foregroundStyle(.pointer)
                .frame(width: 40 ,alignment: .leading)
            
            TextField(hint,text:$text)
        }
        .padding(.horizontal,15)
        .padding(.vertical,15)
        .background{
            RoundedRectangle(cornerRadius: 12 , style: .continuous)
                .fill(.pointer.opacity(0.06))
        }
    }
}
