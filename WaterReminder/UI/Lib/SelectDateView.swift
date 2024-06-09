//
//  SelectDateView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 27/10/1445 AH.
//

import SwiftUI

struct SelectDateView: View {
    var listDate:[DrinkHistory]
    @Binding var selectedDateProgress:DrinkHistory?
    
    @State private var isSelected:Date?
    
    private func initializedAndupdateSelection(with value: ScrollViewProxy) {
        let lastIndex = listDate.count - 1
        isSelected = listDate.last?.drinkDate
        selectedDateProgress = listDate.last
        value.scrollTo(lastIndex, anchor: .trailing)
    }
    
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                HStack(spacing: 0) {
                    ForEach(listDate, id: \.self) { count in
                        DaySelect(progress: CGFloat(count.drinkedProgress),
                                  dayName: count.drinkDate.firstLetterOfWeekDay,
                                  isSelected: isSelected == count.drinkDate,
                                  day: count.drinkDate.formatted(.dateTime.day()))
                        .frame(width: 30)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                self.isSelected = count.drinkDate
                                self.selectedDateProgress = count
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                }
                .padding(.vertical, 15)
                .onAppear {
                    initializedAndupdateSelection(with:value)
                    
                }
                .onChange(of: listDate) {
                    initializedAndupdateSelection(with:value)
                    
                }
                
            }
        }
        
    }
}
