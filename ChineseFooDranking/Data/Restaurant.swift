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
    var rating: Double
    var foodScore: Double
    var serviceScore: Double
    var ambianceScore: Double
    var valueScore: Double
}
