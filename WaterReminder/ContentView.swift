//
//  ContentView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 22/10/1445 AH.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query private var users:[UserProfile]
    @State private var cupSize:Double = 20

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack{
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            
                        }
                       
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            List{
                ForEach(users) { user in
                                    NavigationLink {
                                        VStack {
                                            Text("User: \(user.name)")
                                            if let dailyWater = user.dailyWater {
                                                Text("Today's Water Intake: \(dailyWater.currentDrink.formatted(.number)) mL")
                                                Text("Daily Goal: \(dailyWater.dailyGoal) mL")
                                                
                                                GroupBox(label: Text("hisotry")){
                                                    
                                                        List{
                                                            ForEach(dailyWater.intakeRecords,id:\.drinkTime){item in
                                                                HStack{
                                                                    Text("amount :\(item.drinkinfo)")
                                                                    Spacer()
                                                                    Text("date:\(item.drinkTime)")
                                                                }
                                                            }
                                                    }
                                                }
                                                .padding()
                                            } else {
                                                Text("No water intake recorded for today.")
                                            }
                                          
                                        }
                                        .toolbar {
                                            ToolbarItem(placement: .navigationBarTrailing) {
                                                Button("Log Water") {
                                                    addDaily(for: user)
                                                }
                                            }
                                        }
                                    } label: {
                                        VStack(alignment: .leading) {
                                            Text(user.name)
                                            if let dailyWater = user.dailyWater {
                                                Text("Today's Intake: \(dailyWater.currentDrink) mL")
                                            }
                                        }
                                    }
                                }
                            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
           
                
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func addDaily(for user: UserProfile) {
        withAnimation {
            if let dailyWater = user.dailyWater {
                // Increment existing daily water record
                dailyWater.addIntake(amount: cupSize.)
                try? modelContext.save()
            } else {
                // Create new daily water record if it doesn't exist
                let newDailyWater = DailyWaterDrink(dailyDate: Date(), dailyGoal: 3000, currentDrink: cupSize)
                user.dailyWater = newDailyWater
                user.dailyWater?.addIntake(amount: cupSize)
                modelContext.insert(newDailyWater)
            }
        }
    }
    


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Item.self,UserProfile.self], inMemory: true)
}
