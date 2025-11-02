//
//  ContentView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    @State private var selectedRestaurant: Restaurant?
    @State private var addButtonClicked = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AppHeader()
                    Champions(
                        topRestaurants: restaurantManager.top3Champions,
                    )
                    HStack {
                        Text("Wszystkie Restauracje")
                            .font(.title2).fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    ForEach(restaurantManager.restaurants) { restaurant in
                        RestaurantCard(restaurant: restaurant) { updatedRestaurant in
                            restaurantManager.updateRestaurant(updatedRestaurant)
                        }
                        .padding(.horizontal, 20)
                    }
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
                .environmentObject(restaurantManager)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(RestaurantManager())
}
