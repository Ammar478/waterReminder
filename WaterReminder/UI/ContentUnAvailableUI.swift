//
//  ContentUnAvailableUI.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 28/10/1445 AH.
//

import SwiftUI

struct ContentUnAvailableUI: View {
    var unAvailableContentDescription:String
    var body: some View {
        ContentUnavailableView{
            
            VStack(spacing:10){
                Image(systemName: "list.clipboard")
                    .renderingMode(.original)
                    .font(.system(size: 52))
                    .foregroundStyle(.pointer)
                
                
                Text(unAvailableContentDescription)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .bold()
                
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentUnAvailableUI(unAvailableContentDescription: "ammar")
}
