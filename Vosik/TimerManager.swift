//
//  TimerManager.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/11/24.
//

import Foundation

class TimerManager {
    static let shared = TimerManager()
    
    private var timer: Timer?
    var elapsedTime: TimeInterval = 0
    var isRunning: Bool {
        timer != nil
    }
    
    private init() {} // Private initialization to ensure singleton instance
    
    func startTimer(interval: TimeInterval = 1.0, repeats: Bool = true, action: @escaping () -> Void) {
        stopTimer() // Stop any existing timer
        elapsedTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { [weak self] _ in
            action()
            self?.elapsedTime += interval
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0
    }
}

