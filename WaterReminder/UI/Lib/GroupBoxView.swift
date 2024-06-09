//
//  GroupBoxView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 24/10/1445 AH.
//

import SwiftUI

struct GroupBoxView<Content: View>: View {
    var title: String
    var icon: String
    let content: Content
    

    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
          self.title = title
          self.icon = icon
          self.content = content()
       
      }

    var body: some View {
        GroupBox {
            content
        } label: {
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.p1)
            }
            
        }
       
    }
}


#Preview {
    GroupBoxView(title: "History", icon: "clock.arrow.circlepath") {
                   VStack {
                       Text("No history available")
                           .padding()
                       Text("Try adding some records.")
                           .padding()
                   }
               }
}
