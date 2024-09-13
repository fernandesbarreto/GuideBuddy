//
//  MapUFPE.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 12/09/24.
//

import SwiftUI

struct MapUFPE: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var lastScale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Container que engloba o mapa e os prédios
                ZStack {
                    // Imagem do mapa
                    Image("MapUFPE")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // View que contém os prédios
                    BuildingView(buildings: [
                        Building(image: "CFCH", position: CGPoint(x: 98, y: 335)),
                        Building(image: "CAC", position: CGPoint(x: 300, y: 500))
                    ])
                }
                .scaleEffect(scale) // Aplicando o zoom em todo o container
                .offset(x: offset.width, y: offset.height) // Aplicando o movimento em todo o container
                .gesture(DragGesture()
                    .onChanged { value in
                        offset = CGSize(
                            width: lastOffset.width + value.translation.width,
                            height: lastOffset.height + value.translation.height
                        )
                    }
                    .onEnded { _ in
                        lastOffset = offset // Salvando a última posição após o arrasto
                    }
                )
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        scale = lastScale * value // Aplicando o zoom com base no último valor
                    }
                    .onEnded { value in
                        lastScale = scale // Salvando o último estado do zoom
                    }
                )
            }
            .edgesIgnoringSafeArea(.all) // Faz com que o mapa ocupe toda a tela
        }
    }
}
#Preview {
    MapUFPE()
}
