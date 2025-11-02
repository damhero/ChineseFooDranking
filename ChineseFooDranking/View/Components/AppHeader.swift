//
//  AppHeader.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 30/10/2025.
//
import SwiftUI

struct AppHeader: View {
    private var appGradient: LinearGradient {
            LinearGradient(
                colors: [.orange, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(appGradient)
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white) // Zakładam, że ikona ma być biała
            }
            Text("Wok Log")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundStyle(appGradient)
            
            Text("Najlepsze chinole w mieście!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    AppHeader()
}
