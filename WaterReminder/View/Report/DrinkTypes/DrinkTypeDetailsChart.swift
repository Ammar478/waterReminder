//
//  DrinkTypeDetailsChart.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 07/11/1445 AH.
//
import SwiftUI
import Charts
import SwiftData

struct DrinkTypeDetailsChart: View {
//    @Query private var dataModel:[DrinkHistory]
    let dataModel = generateMockDrinkHistories(for: 5, year: 2024)
    
    @State private var selectedDrinkType: DrinkTypes? = .juices
    var analyzed: DrinkAnalysis {
        analyzeDrinks(dataModel: dataModel)
    }
    @State private var animate: Bool = false
    
    private var drinkTypeCounts: [(type: DrinkTypes, amount: Double)] {
        var counts: [DrinkTypes: Double] = [:]
        
        for history in dataModel {
            for record in history.drinkRecored {
                counts[record.drinkinfo.drinkType, default: 0] += record.drinkinfo.amount
            }
        }
        
        
        return counts.map { (key: $0.key, value: $0.value) }
            .sorted { $0.value > $1.value }
            .map { (type: $0.key, amount: $0.value) }
    }
    
   
    
    var body: some View {
        List{
                
                    
            Text("Hydration for the past \(dataModel.count) days is \(String(format: "%.2f", analyzed.highestHydration ?? 0))%")
                        .font(.headline)
                        .padding(.bottom)
                    
                    Chart(drinkTypeCounts,id: \.type) {entry in
                        
                        BarMark(
                            x: .value("Amount", entry.amount),
                            y: .value("Drink Type", entry.type.title)
                        )
                        .cornerRadius(8, style: .circular)
                        .opacity(entry.type == analyzed.bestDrinkType ? 1 : 0.4)
                        .foregroundStyle(.linearGradient(colors: [ entry.type.color], startPoint: .leading, endPoint: .trailing))
                        .accessibilityLabel(entry.type.title)
                        .accessibilityValue("\(entry.amount) mL")
                        .annotation(position: .overlay, alignment: .trailing, spacing: 12) {
                            Text("\(String(format: "%.0f", entry.amount)) mL")
                                .font(.caption)
                                .foregroundColor(.primary)
                                .padding(2)
                                .background(Color(.systemBackground).opacity(0.7))
                                .cornerRadius(3)
                            
                        }
                        
                    }
                    .frame(height: 300)
                    
                    .chartLegend(.hidden)
                    
         
                
                
                Section {
                    ForEach(drinkTypeCounts, id: \.type) { type in
                        CardContent(label: type.type.title, value: "\(String(format: "%.0f", type.amount / Double(dataModel.count))) mL/day", color: type.type.color)
                            .listRowBackground(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)).padding(.vertical,6))
                            .padding(10)
                            .listRowSeparator(.hidden)
                    }
                }header: {
                    Text("Average Daily Consumption per Drink Type")
                }
                
                Section {
                    let total = drinkTypeCounts.map { $0.amount }.reduce(0, +)
                    ForEach(drinkTypeCounts, id: \.type) { type in
                        CardContent(label: type.type.title, value: "\(String(format: "%.0f", (type.amount / total) * 100))%", color: type.type.color)
                            .listRowBackground(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)).padding(.vertical,6))
                            .padding(10)
                            .listRowSeparator(.hidden)
                    }
                }header: {
                    Text("Percentage Distribution")
                }
                
            
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Drink Types")
        .navigationBarTitleDisplayMode(.inline)
        .background(Rectangle()
            .fill(.linearGradient(colors: [.orange.opacity(0.3), .clear, .clear], startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
        )
    }
}
