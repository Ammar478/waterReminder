//
//  PersonalViewModal.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 15/07/2024.
//

import Foundation

protocol PersonalViewModal:ObservableObject{
    var activeIntor:PageIntro {get set}
    func createUser (user:UserProfile) async throws
}

extension PersonalViewModal{
    var activeIntor:PageIntro { pagesIntro[0]}
}

final class _PersonalViewModal:PersonalViewModal {
    private var localStorage:LocalStorage
    private var api:API
    
    init(localStorage: LocalStorage, api: API, activeIntor:PageIntro) {
        self.localStorage = localStorage
        self.api = api
        self.activeIntor = activeIntor
    }
    var activeIntor: PageIntro
    
    func createUser(user:UserProfile) async throws  {
        do{
            let createdUser = try await api.createUser(user: user)
           try await self.localStorage.createUser(user: createdUser)
            try await self.api.fetchUsers()
        }catch{
            print("faild to create New user: \(error)")
        }
    }
}
