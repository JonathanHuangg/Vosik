//
//  workOutPlans.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/11/24.
//

import Foundation

class WorkOutPlans {
    static let shared = WorkOutPlans() // Singleton instance
    
    private var entries: [IntensityEntry]? // Private storage to encapsulate data
    
    private init() {} // Private initializer to prevent external instantiation
    
    // Function to reset the data to nil if entries is not nil
    public func conditionalResetData() {
        if self.entries != nil {
            self.resetData()
        }
    }
    
    // Public getter
    public var getEntries: [IntensityEntry]? {
        return entries
    }
    
    // Public setter
    public func setEntries(_ newEntries: [IntensityEntry]) {
        self.entries = newEntries
    }
    
    // Function to reset the data to nil
    public func resetData() {
        self.entries = nil
    }

}


