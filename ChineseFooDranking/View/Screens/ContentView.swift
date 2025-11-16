//
//  ContentView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var selectedRestaurant: Restaurant?
    @State private var addButtonClicked = false
    
    private var sortedRestaurants: [Restaurant] {
        viewModel.restaurants.sorted {
            // Sortuj malejąco (od najwyższej oceny)
            $0.rating ?? 0 > $1.rating ?? 0
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AppHeader()
                    Champions(
                        topRestaurants: Array(sortedRestaurants.prefix(3)),
                        viewModel: viewModel,
                        onSave: { updatedRestaurant in
                            Task {
                                await viewModel.updateRestaurant(updatedRestaurant)
                            }
                        },
                        selectedRestaurant: $selectedRestaurant
                    )
                    HStack {
                        Text("Wszystkie Restauracje")
                            .font(.title2).fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    ForEach(sortedRestaurants) { restaurant in

                        Button(action: {
                            self.selectedRestaurant = restaurant // <-- Ustawia wybraną restaurację
                        }) {
                            RestaurantCard(
                                restaurant: restaurant,
                                viewModel: viewModel,
                                onSave: { updatedRestaurant in
                                    Task {
                                        await viewModel.updateRestaurant(updatedRestaurant)
                                    }
                                }
                            )
                        }
                        .buttonStyle(.plain) // <-- Usuwa domyślny niebieski styl przycisku
                        .padding(.horizontal, 20)
                    }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.fetchRestaurants()
                    }
            }

            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        addButtonClicked = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.red))
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // W ContentView.swift
        .fullScreenCover(item: $selectedRestaurant) { restaurantToDisplay in
            // Ten widok pokaże się, gdy selectedRestaurant NIE jest nil

            RestaurantDetailView(
                restaurant: restaurantToDisplay,
                selectedRestaurant: $selectedRestaurant,
                onSave: { updatedRestaurant in
                    Task {
                        await viewModel.updateRestaurant(updatedRestaurant)
                    }
                }
            )
            .environmentObject(viewModel) // <-- Przekaż ViewModel tutaj
        }
        .background(
            // ... (Twój kod tła)
        )
        // ...
        .background(
            ZStack {
                LinearGradient(
                    colors: [Color.red.opacity(0.1), Color.white],
                    startPoint: .topLeading,
                    endPoint: .topTrailing
                )
                LinearGradient(
                    colors: [Color.red.opacity(0.1), Color.white],
                    startPoint: .bottomLeading,
                    endPoint: .bottomTrailing
                )
            }
            .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $addButtonClicked){
            AddRestaurantView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
}
