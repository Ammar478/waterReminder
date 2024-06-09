//
//  CustomIndicatorView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/11/1445 AH.
//

import SwiftUI

struct CustomIndicatorView: View {
    var totalPages:Int
    var currentPage:Int
    var activeTint:Color = .pointer
    var inActiveTint:Color = .gray.opacity(0.5)
    
    var body: some View {
        HStack{
            ForEach(0..<totalPages,id:\.self){
                Circle()
                    .fill(currentPage == $0 ? activeTint : inActiveTint)
                    .frame(width: 4 , height: 4)
            }
        }
    }
}

