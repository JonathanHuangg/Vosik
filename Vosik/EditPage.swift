//
//  EditPage.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

// Struct for the entry

struct IntensityEntry: Identifiable {
    let id = UUID()
    var name: String
    var minutes: Int
    var percentage: Int
}

struct EditPage: View {
    
    // State array to store entries
    @State private var entries: [IntensityEntry] = []
    
    @ObservedObject var data: ActivityData
    // For the wheel
    @State private var minutes: Int = 0
    @State private var percentage: Int = 10
    
    var activityName: String // passed in from contentView
    // For going back to ContentView
    @Environment(\.presentationMode) var presentationMode
    
    // for keeping track of different copies
    var activityIndex: Int
    
    let minuteSecondRange = Array(1...60)
    let percentageRange = Array(stride(from: 10, through: 100, by: 10))
    
    var body: some View {
        ZStack {
            // For the background
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Base dark color
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).opacity(0.8), // Very subtle sheen
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Back to the base color
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Add the scroll wheels for minute, second, and percentages
                HStack {
                    Picker(selection: $minutes, label: Text("Minutes")) {
                        ForEach(minuteSecondRange, id: \.self) { value in
                            Text("\(value) min").tag(value)
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .frame(width:150)
                    .clipped()
                    .compositingGroup()
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker(selection: $percentage, label: Text("Percentage")) {
                        ForEach(percentageRange, id: \.self) { value in
                            Text("\(value) %").tag(value)
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .frame(width:150)
                    .clipped()
                    .compositingGroup()
                    .pickerStyle(WheelPickerStyle())
                }
                .background(Color.black.opacity(0.4))
                .cornerRadius(30)
                HStack {
                    // Back Button
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: 120, height: 120)
                    .background(Color(red: 240 / 155, green: 162 / 255, blue: 2 / 255))
                    .clipShape(Circle())
                    .padding()
                    
                    
                    // Commit button
                    Button("Commit") {
                        let newEntry = IntensityEntry(name: activityName, minutes: minutes, percentage: percentage)
                        data.entries.append(newEntry)
                        entries.append(newEntry)
                        printCurrentEntries()
                    }
                    .foregroundColor(.white)
                    .font(.title)
                    .frame(width: 120, height: 120)
                    .background(Color.green)
                    .clipShape(Circle())
                    .padding()
                }
                List {
                    ForEach(entries) { entry in
                        HStack {
                            Text("\(entry.minutes) min")
                            Spacer()
                            Text("\(entry.percentage) %")
                        }
                    }
                    .onDelete(perform: deleteEntry)
                }
                .listStyle(PlainListStyle())
                
                
                Spacer()

            }
        }
    }
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
    
    private func printCurrentEntries() {
        for entry in entries {
            print("Entry ID: \(entry.id), Minutes: \(entry.minutes), Percentage: \(entry.percentage)")
        }
    }
}

struct EditPage_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample ActivityData with some mock entries
        let sampleData = ActivityData(entries: [
            IntensityEntry(name: "act1", minutes: 30, percentage: 70),
            IntensityEntry(name: "act2", minutes: 30, percentage: 70),
        ])
        
        // Now pass this sample data to the EditPage for the preview
        EditPage(data: sampleData, activityName: "what", activityIndex: 0)
    }
}
