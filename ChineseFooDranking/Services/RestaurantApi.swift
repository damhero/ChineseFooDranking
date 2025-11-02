//
//  RestaurantApi.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 01/11/2025.
//

import Foundation

class RestaurantApi {
    //TODO: Change this.
    let baseURL = "https://twoja-domena.railway.app/api/restaurants"
    
    func fetchRestaurants() async throws -> [Restaurant] {
        let url = URL(string: baseURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Restaurant].self, from: data)
    }
    
    func updateRestaurant(_ restaurant: Restaurant) async throws  -> Restaurant{
        guard let url = URL(string: "\(baseURL)/\(restaurant.id)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(restaurant)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(Restaurant.self, from: data)
    }
}
