

import Foundation
import SwiftUI
import Observation
import AVFAudio

@Observable
class ViewModelPlayer: NSObject, AVAudioPlayerDelegate {
 var melodies: [Model] = []
    
    var currentTime: TimeInterval = 0.0
    var trackDuration: TimeInterval = 0.0
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
            self.player?.delegate = self
            self.player?.play()
            isPlaying = true
            trackDuration = player?.duration ?? 0.0
            // текущий индекс мелодии
            if let index = melodies.firstIndex(where: { $0.id == melody.id}){
                currentIndex = index
            }
        } catch {
            print("Error \(error.localizedDescription)")
        }
     }
    
    func stop(){
        self.player?.stop()
        self.player = nil
        isPlaying = false
    }
    
    func playPause() {
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }
    
    func seek(to time: TimeInterval){
        player?.currentTime = time
    }
    
    func update(){
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    
    func nextMelody(){
         guard let currentIndex = currentIndex else { return }
         let nextIndex = currentIndex + 1 < melodies.count ? currentIndex + 1 : 0
         play(melody: melodies[nextIndex])
     }
     
     func previousMelody(){
         guard let currentIndex = currentIndex else { return }
         let previousIndex = currentIndex  > 0 ? currentIndex - 1 : melodies.count - 1
         play(melody: melodies[previousIndex])
     }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            nextMelody()
        }
    }
    
    func formatted(duration: TimeInterval) -> String {
        let format = DateComponentsFormatter()
        format.allowedUnits = [.minute, .second]
        format.unitsStyle = .positional
        format.zeroFormattingBehavior = .pad
        return format.string(from: duration) ?? ""
    }
    
    func delete(indexSet: IndexSet) {
        if let index = indexSet.first {
            stop()
            melodies.remove(at: index)
        }
    }
    func delete(melody: Model) {
        if let index = melodies.firstIndex(where: { $0.id == melody.id }) {
            stop()
            melodies.remove(at: index)
        }
    }

  }
