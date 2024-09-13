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
        NavigationStack{
            
            VStack{
                GeometryReader { geometry in
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        ZStack {
                            Image("mapUFPE")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            
                            BuildingView(buildings: [
                                Building(image: "CFCH", position: CGPoint(x: 100, y: 200)),
                                Building(image: "CAC", position: CGPoint(x: 300, y: 500))
                            ])
                        }
                        .scaleEffect(scale)
                        .offset(x: offset.width, y: offset.height)
                        .gesture(DragGesture()
                            .onChanged { value in
                                offset = CGSize(
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                        )
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                scale = lastScale * value
                            }
                            .onEnded { value in
                                lastScale = scale
                            }
                        )
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("Faculdades")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


#Preview {
    MapUFPE()
}
