//
//  ActivityEntry.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI

struct ActivityEntry: View {
    // idea is to connect @binding to @state
    @Binding var activityName: String
    @State private var isEditing = false
    @State private var editableName: String
    
    // This is for the button to music changes
    var onEdit: () -> Void
    
    // initialize editableName
    init(activityName: Binding<String>, onEdit: @escaping () -> Void) {
        self._activityName = activityName
        _editableName = State(initialValue: activityName.wrappedValue)
        self.onEdit = onEdit
    }
    
    var body: some View {
        HStack {
            ZStack {
                if isEditing {
                    TextField("Activity Name", text: $editableName, onCommit: {
                        activityName = editableName // Update front-facing name
                        isEditing = false
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .font(.title)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
                    .font(.title)
                } else {
                    Text(activityName)
                        .padding()
                        .font(.title)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .onTapGesture {
                            self.editableName = self.activityName
                            self.isEditing = true
                        }
                }
            }
            // edit button
            Button(action: onEdit) {
                Image(systemName: "pencil") // Edit icon
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(Color(red: 72 / 255, green: 159 / 255, blue: 181/255))
                .cornerRadius(10)
                .padding(.horizontal, 30)
        }
        .frame(maxWidth: 350, minHeight: 70, maxHeight: 70)
        .background(Color.black.opacity(0.8))
        .cornerRadius(15)
    }
}

// .constant() creates a binding<String>
struct ActivityEntry_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEntry(activityName: .constant("Running"), onEdit: { print("Edit tapped") })
    }
}
