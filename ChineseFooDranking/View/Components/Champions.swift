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
    @EnvironmentObject var restaurantManager: RestaurantManager
    let topRestaurants: [Restaurant]
    
    var body: some View {
        VStack(spacing: 0) {
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
                    
                    RestaurantCard(
                        restaurant: restaurant,
                        onSave: { updated in
                            restaurantManager.updateRestaurant(updated)
                        },
                        medal: medalType
                    )
                    .padding(.horizontal, 20)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .red  // Aktywna kropka
                UIPageControl.appearance().pageIndicatorTintColor = .gray.withAlphaComponent(0.3)  // Nieaktywne 
            }
            .frame(height: 500)
            .padding(.top, -100)
        }
    }
}

#Preview {
    Champions(
        topRestaurants: [Restaurant.preview, Restaurant.preview, Restaurant.preview]
    )
    .environmentObject(RestaurantManager())
}
