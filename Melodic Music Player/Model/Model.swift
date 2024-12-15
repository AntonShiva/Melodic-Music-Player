
import Foundation

struct Model: Identifiable, Codable {
    var id = UUID()
    var name: String
    var artist: String?
    var data: Data
    var image: Data?
    var duration: TimeInterval?
    
}
