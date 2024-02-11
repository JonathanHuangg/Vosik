//
//  ActivityData.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/11/24.
//

// This is meant to track the data for EditPage
// This is the data model

import Foundation

class ActivityData : ObservableObject {
    @Published var entries: [IntensityEntry] = []
    
    init(entries: [IntensityEntry]) {
        self.entries = entries
    }
}
