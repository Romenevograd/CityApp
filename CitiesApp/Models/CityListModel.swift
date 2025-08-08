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
        name: "Полный список городов",
        shortListName: "Полный",
        color: .mint,
        cities: [
            .init(name: "Москва", year: 1147),
            .init( name: "Санкт-Петербург", year: 1703),
            .init(name: "Новосибирск", year: 1893),
            .init(name: "Вена", year: 1147),
            .init(name: "Берлин", year: 1237),
            .init(name: "Варшава", year: 1321),
            .init(name: "Оттава", year: 320),
            .init(name: "Нью-Йорк", year: 420),
            .init(name: "Лондон", year: 520),
            .init(name: "Манчестер", year: 620),
            .init(name: "Рим", year: 720),
            .init(name: "Бразилиа", year: 820),
            .init(name: "Токио", year: 920)

        ]
    )
}
