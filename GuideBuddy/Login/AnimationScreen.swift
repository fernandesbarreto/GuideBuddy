//
//  Documentos.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/09/24.
//

//import Foundation
//import SwiftUI
//
//struct OpacityMovementAnimationView: View {
//    @State private var isVisible = false
//
//    var body: some View {
//        VStack {
//            Spacer()
//            Image("GuideBuddy")
//                .resizable()
//                .frame(width: 106, height: 32)
//                .opacity(isVisible ? 1.0 : 0.0)
//                .offset(x: isVisible ? 0 : -200, y: 0)
//                .animation(.easeIn(duration: 1), value: isVisible)
//            
//            Spacer()
//            
//            Button("Animate") {
//                isVisible.toggle()
//            }
//            .padding()
//        }
//    }
//}
//
//struct OpacityMovementAnimationView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpacityMovementAnimationView()
//    }
//}
import SwiftUI

struct AnimationScreen: View {
    @State private var revealAmount: CGFloat = 0
    @State private var showGuibu: Bool = false
    @State private var firstAnimationComplete: Bool = false
    @State private var showpaw: Bool = false

    var body: some View {
        ZStack {
            VStack{
                if showpaw{
                    Image("paws") // Imagem do vetor "guibu"
                        .resizable()
                        .transition(.scale)
                        .frame(width: 393, height: 85)
//                        .animation(.easeOut(duration: 1.0), value: showpaw)
                        .mask(
                            Rectangle()
                                .frame(width: revealAmount, height: 85) // Controla a área visível da imagem
                        )
                        .animation(.easeInOut(duration: 20.0), value: revealAmount)
                } else {}
            }
            .onAppear {
                withAnimation {
                    revealAmount = 393
                }
            
        }
            .offset(y: 500)
            VStack {
                Spacer()
                
                if firstAnimationComplete {
                    if showGuibu {
                        Image("GuiBu") // Imagem do vetor "guibu"
                            .resizable()
                            .transition(.scale) // Transição com escala
                            .frame(width: 106, height: 32)
                            .animation(.easeInOut(duration: 1.0), value: showGuibu)
                    } else {
                        Image("GuideBuddy") // Imagem do vetor "guidebuddy"
                            .resizable()
                            .transition(.scale) // Transição com escala
                            .frame(width: 230, height: 31)
                            .animation(.easeInOut(duration: 1.0), value: showGuibu)
                    }
                } else {
                    Image("GuideBuddy") // Substitua pelo nome da sua imagem
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 235, height: 31) // Define o tamanho final da imagem
                        .mask(
                            Rectangle()
                                .frame(width: revealAmount, height: 200) // Controla a área visível da imagem
                        )
                        .animation(.easeInOut(duration: 2.0), value: revealAmount)
                }
                
                Spacer()
                
                if firstAnimationComplete {
              
                }
            }
            .onAppear {
                withAnimation {
                    revealAmount = 300
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    firstAnimationComplete = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // Inicia a segunda animação
                        withAnimation {
                            showGuibu.toggle()
                        }
                    }
                }
        }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        AnimationScreen()
    }
}
