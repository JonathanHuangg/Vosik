//
//  MusicPlayer.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import SwiftUI
import AVFoundation
struct MusicPlayer: View {
    
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
            Button("Play Music") {
                playMusic()
            }
        }
    }
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "SO TIRED (Slowed)", withExtension: "mp3") else {
            print("music not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed")
        }
    }
}

#Preview {
    MusicPlayer()
}
