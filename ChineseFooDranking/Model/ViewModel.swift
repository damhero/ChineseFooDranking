//
//  ViewModel.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 01/11/2025.
//

import Foundation
import Combine

@MainActor
class ViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var errorMessage: String? = nil
    
    private let api = RestaurantApi()
    
    func fetchRestaurants() async {
        do {
            self.restaurants = try await api.fetchRestaurants()
        }catch {
            self.errorMessage = "Nie udało się pobrać danych restauracji \(error.localizedDescription)"
        }
    }
    
    func updateRestaurant(_ restaurant: Restaurant) async {
        do {
            let updated = try await api.updateRestaurant(restaurant)
            
            if let index = restaurants.firstIndex(where: {$0.id == updated.id}){
                restaurants[index] = updated
            }
        }catch {
            self.errorMessage = "Nie udało się zaktualizować danych restauracji \(error.localizedDescription)"
        }
    }
    
    func createRestaurant(name: String, address: String, cuisine: String, notes: String, food: Double, service: Double, ambiance: Double, value: Double, favoriteDishes: [String], imageData: Data?) async {
        
        let newRestaurant = NewRestaurantRequest(
            name: name,
            address: address,
            cuisine: cuisine,
            foodScore: food,
            serviceScore: service,
            ambianceScore: ambiance,
            valueScore: value,
            notes: notes,
            favoriteDishes: favoriteDishes
        )
        
        do {
            let createdRestaurant = try await api.createRestaurant(newRestaurant)
            
            if let data = imageData, let newId = createdRestaurant.id {
                try await api.uploadImage(id: newId, imageData: data)
            }
            
            restaurants.append(createdRestaurant)
            
        } catch {
            self.errorMessage = "Nie udało się stworzyć restauracji \(error.localizedDescription)"
        }
    }
    func uploadImage(id: Int64, imageData: Data) async {
            do {
                try await api.uploadImage(id: id, imageData: imageData)
                print("Obrazek pomyślnie zaktualizowany.")
            } catch {
                print("Błąd podczas wysyłania obrazka: \(error)")
                // self.errorMessage = "..."
            }
        }
    
    func deleteRestaurant(_ restaurant: Restaurant) async {
        // 1. Upewnij się, że restauracja ma ID
        guard let id = restaurant.id else {
            print("Błąd: Próba usunięcia restauracji bez ID")
            return
        }
        
        do {
            // 2. Wywołaj API
            try await api.deleteRestaurant(id: id)
            
            // 3. Usuń restaurację z lokalnej listy (UI się odświeży)
            restaurants.removeAll { $0.id == id }
            
        } catch {
            print("Błąd podczas usuwania restauracji: \(error)")
            // self.errorMessage = "Nie udało się usunąć restauracji."
        }
    }
}

