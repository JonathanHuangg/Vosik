import SwiftUI
import AVFoundation

extension TimeInterval {
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = time / 3600
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
}

struct MusicPlayer: View {
    @ObservedObject var musicPlayer: PlayerModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Base dark color
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255).opacity(0.8), // Very subtle sheen
                Color(red: 5 / 255, green: 5 / 255, blue: 5 / 255), // Back to the base color
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack {
                Button(action: {
                    musicPlayer.togglePlayPause()
                }) {
                    Image(systemName: musicPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
                Slider(value: Binding(get: {
                    self.musicPlayer.currentTime
                }, set: { (newTime) in
                    self.musicPlayer.seek(to: newTime)
                }), in: 0...musicPlayer.duration)
                
                // Display the current time and duration
                HStack {
                    Text(musicPlayer.currentTime.stringFromTimeInterval())
                    Spacer()
                    Text(musicPlayer.duration.stringFromTimeInterval())
                }
            }
            .padding()
        }
    }
}

// Correct way to define a preview
struct MusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        // Example usage of MusicPlayer with a PlayerModel
        // Ensure you have a valid audio file named "example" with "mp3" extension in your project
        MusicPlayer(musicPlayer: PlayerModel(resourceName: "SO TIRED (Slowed)", type: "mp3"))
    }
}
