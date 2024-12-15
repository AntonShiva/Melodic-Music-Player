//
//  MelodyStorageService.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 15.12.2024.
//

import Foundation
import Foundation

class MelodyStorageService {
    private var melodiesURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("melodies.json")
    }
    
    func saveMelodies(_ melodies: [Model]) {
        do {
            // Создаем временный массив без аудиоданных
            let savedMelodies = melodies.map { melody in
                var savedMelody = melody
                savedMelody.data = Data() // Не сохраняем аудиоданные в JSON
                return savedMelody
            }
            
            let data = try JSONEncoder().encode(savedMelodies)
            try data.write(to: melodiesURL)
            
            // Сохраняем аудиофайлы отдельно
            for melody in melodies {
                let audioURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("\(melody.id).audio")
                try melody.data.write(to: audioURL)
            }
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
    
    func loadMelodies() -> [Model] {
        do {
            let data = try Data(contentsOf: melodiesURL)
            var melodies = try JSONDecoder().decode([Model].self, from: data)
            
            // Загружаем аудиоданные для каждой мелодии
            for index in melodies.indices {
                let audioURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("\(melodies[index].id).audio")
                if let audioData = try? Data(contentsOf: audioURL) {
                    melodies[index].data = audioData
                }
            }
            
            return melodies
        } catch {
            print("Ошибка загрузки: \(error)")
            return []
        }
    }
}
