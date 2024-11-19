

import Foundation
import Observation
import UIKit

@Observable
class ViewModel {
    var melodies: [Model] = []
    
    func formatted(duration: TimeInterval) -> String {
        let format = DateComponentsFormatter()
        format.allowedUnits = [.minute, .second]
        format.unitsStyle = .positional
        format.zeroFormattingBehavior = .pad
        return format.string(from: duration) ?? ""
    }

    }
