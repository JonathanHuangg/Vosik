//
//  ActivitiesViewModel.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/11/24.
//

import Foundation

// map each activity to its data
// Works in conjunction with ActivityData
// Viewmodel part of MVVM
class ActivitiesViewModel : ObservableObject {
    @Published var activityData: [String : ActivityData] = [:]
    
    func dataForActivity(named name: String) -> ActivityData {
        if let data = activityData[name] {
            return data
        } else {
            let newData = ActivityData(entries: [])
            activityData[name] = newData
            return newData
        }
    }
}
