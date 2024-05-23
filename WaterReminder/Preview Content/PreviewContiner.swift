//
//  PreviewContiner.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 23/10/1445 AH.
//

import Foundation
import SwiftData

struct Preview {
    let continer:ModelContainer
    init(_ models:any PersistentModel.Type...){
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        
        do{
            continer = try ModelContainer(for: schema, configurations: config)
        }catch{
            fatalError("could not create mode model schema")
        }
    }
    
    func addExample(_ examples:[any PersistentModel]){
        Task{ @MainActor in
            examples.forEach{example in
                example.modelContext?.insert(example)
            }
        }
    }
}
