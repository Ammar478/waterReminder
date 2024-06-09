//
//  PersonalInfoView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/11/1445 AH.
//

import SwiftUI

struct PersonalInfoView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var age: Int = 20
    @State private var height: Int = 160
    @State private var weight: Int = 60
    @State private var gender: Gender = .male
    @State private var activityLevel: ActivityLevel = .active
    
    var body: some View {
        Form {
            VStack(alignment: .leading){
                
                CustomPickerField(selection: $age, label: "Age", leadingIcon: Image(systemName: "calendar")) {
                    ForEach(15...110, id: \.self) { age in
                        Text("\(age)").tag(age)
                    }
                }
                
                CustomPickerField(selection: $height, label: "Height", leadingIcon: Image(systemName: "arrow.up.and.down")) {
                    ForEach(100...220, id: \.self) { height in
                        Text("\(height) cm").tag(height)
                    }
                }
                
                CustomPickerField(selection: $weight, label: "Weight", leadingIcon: Image(systemName: "scalemass")) {
                    ForEach(30...200, id: \.self) { weight in
                        Text("\(weight) kg").tag(weight)
                    }
                }
                
                CustomPickerField(selection: $gender, label: "Gender", leadingIcon: Image(systemName: "person.2")) {
                    ForEach(Gender.allCases, id: \.id) { gender in
                        Text(gender.rawValue.capitalized).tag(gender)
                    }
                }
                
                CustomPickerField(selection: $activityLevel, label: "Activity Level", leadingIcon: Image(systemName: "figure.walk")) {
                    ForEach(ActivityLevel.allCases, id: \.self) { level in
                        Text(level.rawValue.capitalized).tag(level)
                    }
                }
                
                Spacer(minLength: 10)
                
                Button{
                    addPersonlInfoToUser()
                }label: {
                    Text("Let's Flow")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.vertical,15)
                        .frame(maxWidth: .infinity)
                        .background{
                            Capsule()
                                .fill(.pointer)
                        }
                }
            }
            .padding(.top,25)
        }
        .formStyle(.columns)
    }
    func addPersonlInfoToUser(){
        let newUser = UserProfile(name: "",
                                  age: self.age,
                                  height: self.height,
                                  weight: self.weight,
                                  gender: self.gender,
                                  activityLevel: self.activityLevel)
        modelContext.insert(newUser)
        newUser.addNewUser()
        
    }
}







