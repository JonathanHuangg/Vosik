//
//  ContentView.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

struct ContentView: View {  
    
    // @State private var activityName: String = "Running"
    // This is used because you want to add multiple entries
    @State private var activityNames: [String] = ["Activity 1"]
    @State private var isEditing: Bool = false
    @State private var selectedActivityIndex: Int? = nil
    
    // Track ActivityData
    @StateObject private var viewModel = ActivitiesViewModel()
    
    
    let connector = MySQLDatabaseConnector(
        hostname: "36.226.83.161",
        port: 3306,
        username: "henry",
        password: "Aa&10220305",
        database: "Vosik"
    )

    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Base dark color
                    Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).opacity(0.8), // Very subtle sheen
                    Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Back to the base color
                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                VStack() {
                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding(.horizontal, 30)
                        Button(action: {
                            print("Preferences clicked")
                        }) {
                            Text("Preferences")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(50)
                                .padding(.horizontal, 50)
                        }
                    }
                    .padding(.bottom, 20)
                    List {
                        ForEach(Array(activityNames.enumerated()), id: \.offset) { index, name in
                            NavigationLink(destination: EditPage(data: viewModel.dataForActivity(named: name), activityName: name, activityIndex: index)) {
                                ActivityEntry(activityName: .constant(name), onEdit: {
                                    print("Edit for \(activityNames[index])")
                                })
                            }
                            .padding()
                            .listRowInsets(EdgeInsets()) // This will remove the default padding
                            .listRowBackground(Color.clear) // This will make the background of the row clear
                        }
                        .onDelete(perform: deleteActivity)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                        
                    HStack {
                        // Invisible Button for Layout Balancing
                        Button(action: {}) {
                            VStack {
                                Text("Entry")
                                Text(" ")
                            }
                            .foregroundColor(.clear)
                            .padding()
                        }
                        .background(Color.clear)
                        .cornerRadius(50)
                        .hidden()
                            
                        Spacer()
                            
                        Button(action: {
                            if let firstActivityName = activityNames.first {
                                let activityData = viewModel.dataForActivity(named: firstActivityName)
                                printActivityData(activityData)
                                // Public getter
                                do {
                                    try workOutPlan.conditionalResetData()
                                } catch {
                                    let workOutPlan = WorkOutPlans.shared
                                    workOutPlan.setEntries(activityData)
                                }
                            }; setupAndSendMessage()
                        }) {
                            Text("START!")
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(Color(red: 240 / 155, green: 162 / 255, blue: 2 / 255))
                                .cornerRadius(50)
                                .padding()
                        }
                        Spacer()
                            
                        Button(action: {
                            activityNames.append("Activity \(activityNames.count + 1)")
                        }) {
                            VStack {
                                Text("Add")
                                Text("Entry")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .bold()
                        }
                        .background(Color.gray)
                        .cornerRadius(50)
                    }
                }
            }
        }
    }
        
    func deleteActivity(at offsets: IndexSet) {
        activityNames.remove(atOffsets: offsets)
    }
    func printActivityData(_ data: ActivityData) {
        for entry in data.entries {
            print("Name \(entry.name): \(entry.minutes) minutes at \(entry.percentage)% intensity   id: \(entry.id)")
        }
    }
    private func setupAndSendMessage() {
        DispatchQueue.global(qos: .userInitiated).async {
            connector.executeQuery("SELECT * FROM songs") { result in
                switch result {
                case .success(let rows):
                    for row in rows {
                        // Process each row
                        print(row)
                    }
                case .failure(let error):
                    print("Failed to execute query: \(error)")
                }
            }
//            self.tcpClient.setupConnection(toHost: "36.226.83.161", port: 3306)
//            self.tcpClient.sendMessage(message: "0.5:0.9")
//            
//            // Read the response from the server
//            if let response = self.tcpClient.readResponse() {
//                DispatchQueue.main.async {
//                    // Print the response or update the UI here
//                    print("Response from server: \(response)")
//                }
//            }
//            
//            self.tcpClient.stopConnection()
        }
    }
}
    
#Preview {
    ContentView()
}
