//
//  HydrationListView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/12/1445 AH.
//

import SwiftUI

struct HydrationListView: View {
    let histories: [DrinkHistory]
    var body: some View {
        List {
            intakeSection
            goalSection
            highlightsSection
        }
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
    }

    private var intakeSection: some View {
        Section {
            NavigationLink(value: ReportDestinations.intake) {
                WaterIntakeOverviewChart()
            }
        }
    }

    private var goalSection: some View {
        Section {
            NavigationLink(value: ReportDestinations.goal) {
                DrinkTypePieChartView()
            }
        }
    }

    private var highlightsSection: some View {
        Section {
            ForEach([
                ("Total Intake with mL", String(format: "%.0f", histories.totalIntake()), Color.blue),
                ("Average Goal", String(format: "%.0f", histories.averageGoal()), Color.green),
                ("Achievement Rate", "\(histories.achievementRate()) %", Color.orange)
            ], id: \.0) { label, value, color in
                CardContent(label: label, value: value, color: color)
                    .listRowBackground(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)).padding(.vertical, 6))
                    .padding(10)
                    .listRowSeparator(.hidden)
            }
        } header: {
            HStack(alignment: .center, spacing: 7) {
                Image(systemName: "flag.circle.fill")
                Text("Highlights")
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }}
