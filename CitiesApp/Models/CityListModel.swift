import Foundation
import SwiftUI

struct CityListModel: Hashable, Identifiable {
    let id: String
    let name: String
    let shortListName: String
    let color: Color
    var cities: [CityModel]
    
    init(
        name: String,
        shortListName: String,
        color: Color,
        cities: [CityModel]
    ) {
        self.id = UUID().uuidString
        self.name = name
        self.shortListName = shortListName
        self.color = color
        self.cities = cities
    }
    
    static let `default` = Self(
        name: "По умолчанию",
        shortListName: "Базовый",
        color: .mint,
        cities: [
            .init(name: "Москва", year: 1147),
            .init( name: "Санкт-Петербург", year: 1703),
            .init(name: "Новосибирск", year: 1893),
            .init(name: "Вена", year: 1147),
            .init(name: "Берлин", year: 1237),
            .init(name: "Варшава", year: 1321),
            .init(name: "Милан", year: 1899)
        ]
    )
}
