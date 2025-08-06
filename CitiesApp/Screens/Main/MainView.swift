import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    @State private var isMenuPresented = false
    @State private var editMode: EditMode = .inactive
    @State private var isCreateListPresented = false
    
    private var defaultCities: [CityModel] {
        viewModel.citiesLists.filter { $0 == .default }.flatMap(\.cities)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                CitiesListView(
                    cities: viewModel.currentList.cities,
                    deleteCities: viewModel.deleteCities,
                    moveCities: viewModel.moveCities
                )
                
                Spacer()
                
                actionsView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.currentList.name)
        .sheet(isPresented: $isMenuPresented) {
            ColorSelectionCarousel(
                citiesLists: viewModel.citiesLists,
                currentList: viewModel.currentList,
                createList: {
                    isMenuPresented = false
                    isCreateListPresented = true
                },
                selectList: { id in
                    viewModel.selectCitiesList(id)
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(24)
        }
        .sheet(isPresented: $isCreateListPresented) {
            CreateListView(
                cities: defaultCities,
                addList: { model in
                    viewModel.updateCitiesList(model)
                }
            )
        }
    }
    
    private func actionsView() -> some View {
        HStack(spacing: .zero) {
            Button {
                print("Меню нажато")
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding()
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(32)
            }
            
            Spacer()
            
            Button {
                isMenuPresented.toggle()
            } label: {
                VStack {
                    Image(systemName: isMenuPresented ? "chevron.down" : "chevron.up")
                        .frame(width: 32, height: 32)
                        .padding()
                        .background(viewModel.currentList.color)
                        .foregroundColor(.white)
                        .cornerRadius(32)
                    Text("\(viewModel.currentList.shortListName)")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal, 32)
        .shadow(radius: 8)
    }
}
