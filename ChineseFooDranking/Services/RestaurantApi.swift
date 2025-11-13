//
//  RestaurantApi.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 01/11/2025.
//

import Foundation

class RestaurantApi {
    let baseURL = "http://212.132.73.162:8081/api/restaurants"
    
    func fetchRestaurants() async throws -> [Restaurant] {
        let url = URL(string: baseURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Restaurant].self, from: data)
    }
    
    func updateRestaurant(_ restaurant: Restaurant) async throws  -> Restaurant{
        guard let id = restaurant.id else {
            throw URLError(.badURL)
        }
        guard let url = URL(string: "\(baseURL)/\(id)") else {
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
    func createRestaurant(_ newRestaurant: NewRestaurantRequest) async throws  -> Restaurant{
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(newRestaurant)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(Restaurant.self, from: data)
    }
    
    func uploadImage(id: Int64, imageData: Data) async throws {
        guard let url = URL(string: "\(baseURL)/\(id)/image") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body  = Data()
        
        body.appendString("--\(boundary)\r\n")
            
        // "name" musi pasować do @RequestParam("image") w Springu
        // "filename" to dowolna nazwa, jaką zobaczy serwer
        body.appendString("Content-Disposition: form-data; name=\"image\"; filename=\"upload.jpg\"\r\n")
        
        // Typ pliku
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        
        // Właściwe dane obrazka
        body.append(imageData)
        
        // Zakończenie pliku
        body.appendString("\r\n")
        // --- Koniec części z plikiem ---

        // Końcowa granica (boundary)
        body.appendString("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
                
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        print("Obrazek wysłany pomyślnie!")
    }
    
    func deleteRestaurant(id: Int64) async throws {
        // 1. Stwórz URL, np. ".../api/restaurants/8"
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw URLError(.badURL)
        }
        
        // 2. Stwórz żądanie DELETE
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        // 3. Wyślij żądanie
        let (_, response) = try await URLSession.shared.data(for: request)
        
        // 4. Sprawdź, czy serwer odpowiedział poprawnie (200 OK lub 204 No Content)
        guard let httpResponse = response as? HTTPURLResponse,
              (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) else {
            throw URLError(.badServerResponse)
        }
        
        print("Pomyślnie usunięto restaurację o ID: \(id)")
    }
}
extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
