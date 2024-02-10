//
//  ActivityEntry.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

struct ActivityEntry: View {
    var activityName: String
    var body: some View {
        HStack {
            Text(activityName)
                .padding()
                .foregroundColor(.white)
            Spacer()
            
            Button(action: {
                print("Edit toggled")
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.white)
            }
        }
        .background(Color.black.opacity(0.8)) // Optional: Adjust HStack background as needed
        .cornerRadius(15) // Optional: Adjust corner radius for the whole component
    }
}

#Preview {
    ActivityEntry(activityName: "Running")
}
