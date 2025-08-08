import SwiftUI

struct CreateListView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var shortListName = ""
    @State private var selectedColor = "Зеленый"
    @State private var selectedCities = Set<String>()
    @State private var maxCitiesSelection = 5
    @State private var maxSymbolsShortName = 7
    
    private let colors: [String: Color] = [
        "Красный": .red,
        "Зеленый": .green,
        "Синий": .blue,
        "Оранжевый": .orange
    ]
    
    private let cities: [CityModel]
    private let addList: (CityListModel) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Название списка")) {
                    TextField("Введите название", text: $name)
                }
                
                Section(header: Text("Короткое название списка(макс.\(maxSymbolsShortName) символов)")) {
                    TextField("Введите короткое название", text: $shortListName)
                        .onChange(of: shortListName) { oldValue, newValue in
                            if newValue.count > maxSymbolsShortName {
                                shortListName = String(newValue.prefix(maxSymbolsShortName))
                            }
                        }
                }
                
                Section(header: Text("Цвет списка")) {
                    Picker("Выберите цвет", selection: $selectedColor) {
                        ForEach(colors.map(\.key), id: \.self) { name in
                            Text(name.capitalized)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Выберите города(Максимум \(maxCitiesSelection))")) {
                    List(cities) { city in
                        HStack {
                            Toggle(isOn: Binding(
                                get: { selectedCities.contains(city.id) },
                                set: { isSelected in
                                    if isSelected {
                                        if selectedCities.count < maxCitiesSelection {
                                            selectedCities.insert(city.id)
                                        }
                                    } else {
                                        selectedCities.remove(city.id)
                                    }
                                }
                            )) {
                                HStack(spacing: 10) {
                                    Text(city.name)
                                    Text("\(city.year) год")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                            .disabled(selectedCities.count >= maxCitiesSelection && !selectedCities.contains(city.id) )
                        }
                        .padding(.horizontal, 10)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Новый список городов")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        let cities = cities.filter { selectedCities.contains($0.id) }
                        addList(.init(
                            name: name,
                            shortListName: shortListName,
                            color: colors.first(where: { $0.key == selectedColor })?.value ?? .random,
                            cities: cities
                        ))
             
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    init(
        cities: [CityModel],
        addList: @escaping (CityListModel) -> Void
    ) {
        self.cities = cities
        self.addList = addList
    }
}

