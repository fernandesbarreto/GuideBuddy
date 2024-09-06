////
////  PhotoSheet.swift
////  GuiBu
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
////
//
//import SwiftUI
//
//struct ProfilePhotoSheet: View {
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack {
//            // Botão que abre o sheet
//            Button(action: {
//                showSheet.toggle()
//            }) {
//                Text("Editar foto do perfil")
//            }
//        }
//        .sheet(isPresented: $showSheet) {
//            VStack {
//                Text("Editar foto do perfil")
//                    .font(.headline)
//                    .padding()
//
//                Divider()
//
//                // Opção para tirar foto
//                Button(action: {
//                    // Ação para tirar foto
//                }) {
//                    HStack {
//                        Image(systemName: "camera")
//                        Text("Tirar foto")
//                    }
//                    .padding()
//                }
//
//                Divider()
//
//                // Opção para escolher foto
//                Button(action: {
//                    // Ação para escolher foto
//                }) {
//                    HStack {
//                        Image(systemName: "photo")
//                        Text("Escolher foto")
//                    }
//                    .padding()
//                }
//
//                Divider()
//
//                // Opção para apagar foto
//                Button(action: {
//                    // Ação para apagar foto
//                }) {
//                    HStack {
//                        Image(systemName: "trash")
//                        Text("Apagar foto")
//                            .foregroundColor(.red)
//                    }
//                    .padding()
//                }
//
//                Spacer()
//            }
//            .padding()
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        ProfilePhotoSheet()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
