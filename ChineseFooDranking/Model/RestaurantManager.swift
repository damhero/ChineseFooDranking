//
//  RestaurantManager.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 21/10/2025.
//

import Foundation
internal import Combine
import UIKit

class RestaurantManager: ObservableObject {
    @Published var restaurants: [Restaurant] = [
        Restaurant(
                    name: "Golden Dragon Palace",
                    address: "128 Main Street, Chinatown",
                    cuisine: "Cantonese",
                    imageData: UIImage(named: "Cover1")?.jpegData(compressionQuality: 0.8),
                    foodScore: 9.0,
                    serviceScore: 8.0,
                    ambianceScore: 9.0,
                    valueScore: 7.0,
                    favoriteDishes: ["kurczak", "krewetki"],
                    notes: "Kurczak z miode to jest taki benger ze nawet sobi tego nie wyobrazasz bratku."
                )
    ]
    
    func addRestaurant(_ restaurant: Restaurant) {
        restaurants.append(restaurant)
    }
    
    func deleteRestaurant(at index: Int) {
        restaurants.remove(at: index)
    }
    
    func updateRestaurant(_ restaurant: Restaurant){
        if let index = restaurants.firstIndex(where: { $0.id == restaurant.id}) {
            restaurants[index] = restaurant
        }
    }
}

    

