import SwiftUI

struct ColorSelectionCarousel: View {
    @State private var selectedColorIndex = 0
    @State private var name = ""
    @State private var nameOpacity = 1.0
    @State private var scrollProxy: ScrollViewProxy?
    
    private var colors: [Color] {
        citiesLists.map(\.color)
    }
    
    private let defaultDiameter: CGFloat = 48
    private let selectedDiameter: CGFloat = 72
    private let circleSpacing: CGFloat = 24
    private let coordinateSpaceName = "ColorSelectionCarousel"
    
    private let citiesLists: [CityListModel]
    private let selectList: (String) -> Void
    private let createList: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: .zero) {
                Spacer()

                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: circleSpacing) {
                            if geometry.size != .zero {
                                Color.clear
                                    .frame(width: (geometry.size.width - selectedDiameter) * 0.5 - circleSpacing)
                            }
                            
                            ForEach(colors.indices, id: \.self) { index in
                                colorCircle(index: index)
                                    .id(index)
                            }
                            
                            if geometry.size != .zero {
                                Color.clear
                                    .frame(width: (geometry.size.width - selectedDiameter) * 0.5 - circleSpacing)
                            }
                        }
                        .frame(height: selectedDiameter + 16)
                    }
                    .coordinateSpace(name: coordinateSpaceName)
                    .onAppear {
                        scrollProxy = proxy
                        centerSelectedItem()
                    }
                }
                
                Text(name)
                    .font(.body.bold())
                    .padding(.vertical, 16)
                    .opacity(nameOpacity)
            
                Spacer()
                
                addColorButton()
            }
        }
    }
    
    init(
        citiesLists: [CityListModel],
        currentList: CityListModel,
        createList: @escaping () -> Void,
        selectList: @escaping (String) -> Void,
    ) {
        self.citiesLists = citiesLists
        _name = .init(initialValue: currentList.name)
        _selectedColorIndex = .init(initialValue: citiesLists.firstIndex(of: currentList) ?? 0)
        self.createList = createList
        self.selectList = selectList
    }
        
    private func addColorButton() -> some View {
        Button {
            createList()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: selectedDiameter, height: selectedDiameter)
                .foregroundColor(.gray)
                .padding(.vertical, 8)
        }
    }
    
    private func colorCircle(index: Int) -> some View {
        Circle()
            .fill(colors[index])
            .frame(
                width: isSelected(index) ? selectedDiameter : defaultDiameter,
                height: isSelected(index) ? selectedDiameter : defaultDiameter
            )
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: isSelected(index) ? 3 : 0)
                    .shadow(radius: isSelected(index) ? 2 : 0)
            )
            .transition(.scale)
            .onTapGesture {
                selectColor(index: index)
            }
            .padding(.vertical, 8)
    }
    
    private func selectColor(index: Int) {
        guard selectedColorIndex != index else { return }
        
        withAnimation {
            nameOpacity = 0
            selectedColorIndex = index
            centerSelectedItem()
        } completion: {
            let model = citiesLists[index]
            name = model.name
            nameOpacity = 1
            selectList(model.id)
        }
    }
    
    private func centerSelectedItem() {
        scrollProxy?.scrollTo(selectedColorIndex, anchor: .center)
    }
    
    private func isSelected(_ index: Int) -> Bool {
        index == selectedColorIndex
    }
}
