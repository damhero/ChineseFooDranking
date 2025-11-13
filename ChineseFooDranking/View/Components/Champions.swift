import SwiftUI

enum MedalType {
    case złoty
    case srebrny
    case brązowy
    
    var color: Color {
        switch self {
        case .złoty:
            return .yellow
        case .srebrny:
            return .gray
        case .brązowy:
            return .brown
        }
    }
}

struct Champions: View {
    let topRestaurants: [Restaurant]
    let viewModel: ViewModel
    var onSave: (Restaurant) -> Void
    @Binding var selectedRestaurant: Restaurant?
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "trophy.fill")
                    .foregroundColor(Color.orange)
                    .font(.title2)
                Text("Top 3 Najlepsze")
                    .font(.title2).fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            TabView {
                ForEach(Array(topRestaurants.indices), id: \.self) { index in
                    let restaurant = topRestaurants[index]
                    let medalType: MedalType = {
                        switch index {
                        case 0: return .złoty
                        case 1: return .srebrny
                        default: return .brązowy
                        }
                    }()
                    
                    Button(action: {
                            self.selectedRestaurant = restaurant
                        }) {
                            RestaurantCard(
                                restaurant: restaurant,
                                viewModel: viewModel, // Upewnij się, że ten parametr jest
                                onSave: onSave,
                                medal: medalType
                            )
                        }
                        .buttonStyle(.plain) // Usuwa domyślny niebieski styl przycisku
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .red  // Aktywna kropka
                UIPageControl.appearance().pageIndicatorTintColor = .gray.withAlphaComponent(0.3)  // Nieaktywne 
            }
            .frame(height: 450)
        }
    }

#Preview {

    Champions(
        topRestaurants: [Restaurant.preview, Restaurant.preview],
        viewModel: ViewModel(),
        onSave: { _ in print("Preview Save") },
        selectedRestaurant: .constant(nil) 
    )
}
