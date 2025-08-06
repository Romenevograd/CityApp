import Foundation

struct CityModel: Hashable, Identifiable {
    let id: String
    let name: String
    let year: Int
    
    init(
        name: String,
        year: Int
    ) {
        self.id = UUID().uuidString
        self.name = name
        self.year = year
    }
}

