
import Foundation

struct Model: Identifiable {
    var id = UUID()
    var name: String
    var artist: String?
    var data: Data
    var image: Data?
    var duration: TimeInterval?
    
}
