

import Foundation
import Observation
import AVFAudio

@Observable
class ViewModelPlayer {
    var melodies: [Model] = []
    var player: AVAudioPlayer?
    var isPlaying = false
    
    func play(melody: Model) {
        do {
            self.player = try AVAudioPlayer(data: melody.data)
            self.player?.play()
            isPlaying = true
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func formatted(duration: TimeInterval) -> String {
        let format = DateComponentsFormatter()
        format.allowedUnits = [.minute, .second]
        format.unitsStyle = .positional
        format.zeroFormattingBehavior = .pad
        return format.string(from: duration) ?? ""
    }

  }
