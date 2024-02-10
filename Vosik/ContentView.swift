//
//  ContentView.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activityName: String = "Running"
    
    var body: some View {
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
                
                ActivityEntry(activityName: $activityName, onEdit: {print("hi")})
                Spacer()
                
                Button(action: {
                    print("Start Pressed")
                }) {
                    Text("START!")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color(red: 240 / 155, green: 162 / 255, blue: 2 / 255))
                        .cornerRadius(50)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
