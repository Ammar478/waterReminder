//
//  QueryViewModifier.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI
import SwiftData

struct QueryViewModifier<Content: View, Model: PersistentModel>: View {
    @Environment(\.modelContext) var modelContext
    @Query private var connection: [Model]
    let content: () -> Content
    
    init(
        query: Query<Model, [Model]>,
        content: @autoclosure @escaping () -> Content
    ) {
        self._connection = query
        self.content = content
    }
    
    init(
        query: Query<Model, [Model]>,
        content: @escaping () -> Content
    ) {
        self._connection = query
        self.content = content
    }
    
    var body: some View {
        content()
            .modelContext(modelContext)
    }
}

extension View {
    @ViewBuilder
    func connecting<Model: PersistentModel>(_ query: Query<Model, [Model]>) -> some View  {
        QueryViewModifier(query: query, content: self)
    }
}

#Preview {
    let localStorage = LocalStorage()
    localStorage.mainContext.insert(DrinkHistory(
        drinkDate: Date(),
        drinkGoal: 1000,
        currentDrink: 1000,
        isGoalAchefed: false,
        drinkedProgress: 0.4
    ))
    let query = Query<DrinkHistory, [DrinkHistory]>()
    
    return QueryViewModifier(query: query ) {
        List(query.wrappedValue) { drink in
            Text(drink.drinkDate.formattedDate)
        }
    }
    .connecting(query)
    .modelContainer(localStorage.modelContainer)
}
