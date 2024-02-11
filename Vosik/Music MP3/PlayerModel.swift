//
//  PlayerModel.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import Foundation
import AVFoundation

class PlayerModel : ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    private var timer: Timer?
    
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    
    init(resourceName: String, type: String) {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: type) else {return}
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            duration = audioPlayer?.duration ?? 0
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading file")
        }
    }
    
    func play() {
        audioPlayer?.play()
        isPlaying = true
        startTimer()
    }
    
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
        stopTimer()
    }
    
    func togglePlayPause() {
        isPlaying ? pause() : play()
    }
    
    func startTimer() {
        timer?.invalidate() // get rid of existing timer
        
        // I HAVE NO IDEA WHAT THIS CODE DOES
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                    self?.currentTime = self?.audioPlayer?.currentTime ?? 0
                }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func seek(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        currentTime = time
    }
}
