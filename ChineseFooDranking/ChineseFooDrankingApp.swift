//
//  ChineseFooDrankingApp.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

@main
struct ChineseFooDrankingApp: App {
    @StateObject var restaurantManager = RestaurantManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
