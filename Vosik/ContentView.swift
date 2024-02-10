//
//  ContentView.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Base dark color
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).opacity(0.8), // Very subtle sheen
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Back to the base color
                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
            VStack {
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
                Spacer()
                
                ActivityEntry(activityName: "Running")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
