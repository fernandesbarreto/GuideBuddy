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
                NavigationLink(destination: building.destination) {
                    Image(building.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: building.size.width, height: building.size.height)
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
    let size: CGSize
    let destination: AnyView
}
struct BuildingDetail: Identifiable{
    var id = UUID()
    let title: String
    let description: String
    let image: String
    let navtitle: String
    let cellphoneNumbers: [String]
    let email : [String]
}

let allBuildings: [BuildingDetail] = [
    BuildingDetail(title: "CFCH", description: "Faculdade de Filosofia e Ciências Humanas", image: "cfch_image", navtitle: "CFCH", cellphoneNumbers: ["995215663"], email: [""]),
    BuildingDetail(title: "CAC", description: "Centro de Artes e Comunicação", image: "cac_image", navtitle: "CAC", cellphoneNumbers: ["995215663"], email: [""]),
    BuildingDetail(title: "CIN", description: "Centro de Informática", image: "cin_image", navtitle: "CIN", cellphoneNumbers: ["995215663"], email: [""])
]

#Preview {
    BuildingView(buildings: [
        Building(image: "CFCH", position: CGPoint(x: 100, y: 200), size: CGSize(width: 30, height: 30), destination: AnyView(UFPEPlaces())),
        Building(image: "CAC", position: CGPoint(x: 300, y: 500), size: CGSize(width: 40, height: 40), destination: AnyView(UFPEPlaces())),
        Building(image: "CTG", position: CGPoint(x: 200, y: 400), size: CGSize(width: 35, height: 35), destination: AnyView(UFPEPlaces())),
        Building(image: "Area2", position: CGPoint(x: 200, y: 400), size: CGSize(width: 45, height: 45), destination: AnyView(UFPEPlaces())),
        Building(image: "CIN", position: CGPoint(x: 200, y: 100), size: CGSize(width: 50, height: 50), destination: AnyView(UFPEPlaces())),
        Building(image: "PETROLEO", position: CGPoint(x: 300, y: 200), size: CGSize(width: 30, height: 30), destination: AnyView(UFPEPlaces())),
        Building(image: "PRODUCAO", position: CGPoint(x: 200, y: 300), size: CGSize(width: 60, height: 60), destination: AnyView(UFPEPlaces())),
        Building(image: "CIN1", position: CGPoint(x: 300, y: 300), size: CGSize(width: 30, height: 30), destination: AnyView(UFPEPlaces())),
        Building(image: "CIN2", position: CGPoint(x: 300, y: 350), size: CGSize(width: 30, height: 30), destination: AnyView(UFPEPlaces())),
        Building(image: "CB", position: CGPoint(x: 250, y: 300), size: CGSize(width: 40, height: 40), destination: AnyView(UFPEPlaces())),
        Building(image: "CCS", position: CGPoint(x: 300, y: 250), size: CGSize(width: 35, height: 35), destination: AnyView(UFPEPlaces())),
        Building(image: "CCSA", position: CGPoint(x: 100, y: 100), size: CGSize(width: 50, height: 50), destination: AnyView(UFPEPlaces()))
        ])
}
