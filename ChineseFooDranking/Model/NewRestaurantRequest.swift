//
//  NewRestaurantRequest.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 02/11/2025.
//

import Foundation

struct NewRestaurantRequest: Codable {
    var name: String
    var address: String
    var cuisine: String
    var foodScore: Double
    var serviceScore: Double
    var ambianceScore: Double
    var valueScore: Double
    var notes: String
    var favoriteDishes: [String]
}
