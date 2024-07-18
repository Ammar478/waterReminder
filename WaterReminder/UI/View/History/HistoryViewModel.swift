//
//  HistoryViewModel.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI
import SwiftData

protocol HistoryViewModel: ObservableObject {
    var items :[DrinkHistory] {get set}
    func loadContent() async throws
}

final class _HistoryViewModel :HistoryViewModel {
    private let localStorage:LocalStorage
    private let api: API
    
    let query:Query<DrinkHistory ,[DrinkHistory]>
    @MainActor var items: [DrinkHistory] {
        get {query.wrappedValue}
        set {}
    }
    
    init(localStorage: LocalStorage, api: API) {
        self.localStorage = localStorage
        self.api = api
        self.query = Query(sort:[.init(\.drinkDate,order: .reverse)
                                ],animation: .smooth)
    }
    
    func loadContent() async throws {
        do{
            try await api.fetchDrinkHistories()
        }catch{
            print("load histories content - error:\(error)")
            throw error
        }
    }
}




