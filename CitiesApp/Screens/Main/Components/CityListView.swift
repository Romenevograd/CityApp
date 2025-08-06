import SwiftUI

struct CitiesListView: View {
    @Environment(\.editMode) private var editMode
    
    private let cities: [CityModel]
    
    @State private var selectedCity: CityModel?
    @State private var editedName = ""
    @State private var editedYear = ""
    
    private let deleteCities: (IndexSet) -> Void
    private let moveCities: (IndexSet, Int) -> Void
            
    var body: some View {
        List {
            ForEach(cities) { city in
                HStack {
                    Text(city.name)
                    
                    Spacer()
                    
                    Text("\(city.year) год")
                }
                .frame(height: 40)
                .padding(.horizontal, 16)
                .onTapGesture {
                    guard editMode?.wrappedValue.isEditing == true else { return }
                    
                    selectedCity = city
                    editedName = city.name
                    editedYear = "\(city.year)"
                }
            }
            .onDelete { at in
                deleteCities(at)
            }
            .onMove { from, to in
                moveCities(from, to)
            }
        }
        .listStyle(.plain)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    init(
        cities: [CityModel],
        deleteCities: @escaping (IndexSet) -> Void,
        moveCities: @escaping (IndexSet, Int) -> Void
    ) {
        self.cities = cities
        self.deleteCities = deleteCities
        self.moveCities = moveCities
    }
}
