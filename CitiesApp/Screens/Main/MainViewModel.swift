import SwiftUI

final class MainViewModel: ObservableObject {
    @Published private(set) var currentList: CityListModel = .default
    @Published private(set) var citiesLists: [CityListModel] = [.default]
    
    func selectCitiesList(
        _ id: String
    ) {
        currentList = citiesLists.first(where: { $0.id == id }) ?? .default
    }
    
    func updateCitiesList(
        _ model: CityListModel
    ) {
        citiesLists.append(model)
    }
    
    func deleteCities(
        at offsets: IndexSet
    ) {
        currentList.cities.remove(atOffsets: offsets)
    }
    
    func moveCities(
        from source: IndexSet,
        to destination: Int
    ) {
        currentList.cities.move(fromOffsets: source, toOffset: destination)
    }
    
    func updateCity(
        id: String,
        name: String,
        year: Int
    ) {
        guard let index = currentList.cities.firstIndex(where: { $0.id == id }) else { return }
        
        currentList.cities[index] = .init(
            name: name,
            year: year
        )
    }
}

