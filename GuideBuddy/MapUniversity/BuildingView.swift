//
//  BuildingView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 12/09/24.
//
import SwiftUI

struct BuildingView: View {
    let buildings: [Building]
    
    var body: some View {
        ZStack {
            ForEach(buildings) { building in
                Button(action: {
                    // Ação ao clicar no prédio
                    print("Prédio \(building.image) clicado")
                }) {
                    Image(building.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .padding(8)
                        .shadow(radius: 5)
                        
                }
                .position(x: building.position.x, y: building.position.y)
               
            }
        }
    }
}

struct Building: Identifiable {
    let id = UUID()
    let image: String
    let position: CGPoint
}

#Preview {
    BuildingView(buildings: [
        Building(image: "CFCH", position: CGPoint(x: 100, y: 200)),
        Building(image: "CAC", position: CGPoint(x: 300, y: 500))
    ])
}
