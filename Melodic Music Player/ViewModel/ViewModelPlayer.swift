

import Foundation
import Observation
import AVFAudio

@Observable
class ViewModelPlayer {
    var melodies: [Model] = []
    var player: AVAudioPlayer?
    var isPlaying = false
    var currentIndex: Int?
    // текущая мелодия по текущему индексу
    var currentMelody: Model? {
        guard let index = currentIndex, melodies.indices.contains(index) else { return nil }
        return melodies[index]
    }
    
    func play(melody: Model) {
        do {
            self.player = try AVAudioPlayer(data: melody.data)
            self.player?.play()
            isPlaying = true
            // текущий индекс мелодии
            if let index = melodies.firstIndex(where: { $0.id == melody.id}){
                currentIndex = index
            }
        } catch {
            print("Error \(error.localizedDescription)")
        }
     }
    
    func playPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func formatted(duration: TimeInterval) -> String {
        let format = DateComponentsFormatter()
        format.allowedUnits = [.minute, .second]
        format.unitsStyle = .positional
        format.zeroFormattingBehavior = .pad
        return format.string(from: duration) ?? ""
    }

  }
