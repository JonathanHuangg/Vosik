//
//  AddEntry.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
// This is actually never called, just a sounding board to make the component work
//

import SwiftUI

struct AddEntry: View {
    var body: some View {
        
        Button(action: {
            print("Add Activity Entry")
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

#Preview {
    AddEntry()
}
