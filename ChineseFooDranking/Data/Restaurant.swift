//
//  Restaurant.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 21/10/2025.
//

import Foundation

struct Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var cuisine: String
    var imageData: Data?
    var foodScore: Double
    var serviceScore: Double
    var ambianceScore: Double
    var valueScore: Double
    var favoriteDishes: [String]
    var notes : String
    
    var rating: Double {
            (foodScore + serviceScore + ambianceScore + valueScore) / 4.0
        }
}
