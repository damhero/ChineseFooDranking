//
//  Restaurant.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 21/10/2025.
//

import Foundation

struct Restaurant: Identifiable, Sendable, Codable {
    var id: Int64?
    var name: String
    var address: String
    var cuisine: String
    var foodScore: Double
    var serviceScore: Double
    var ambianceScore: Double
    var valueScore: Double
    var favoriteDishes: [String]
    var notes : String
    
    var rating: Double? {
        (foodScore * 2.0 + serviceScore + ambianceScore + valueScore) / 5.0
    }
    
    var imageURL: URL? {
            guard let id = id else { return nil }
            
            // WAŻNE: Wklej tutaj bazowy URL swojego API
            let baseURL = "http://212.132.73.162:8081/api/restaurants"
            
            return URL(string: "\(baseURL)/\(id)/image")
        }
}
