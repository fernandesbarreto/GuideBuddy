////
////  BackgroundImageView.swift
////  GuiBu
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
////
//
//import SwiftUI
//
//struct BackgroundImageView: View {
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerPresented = false
//    @State private var isBackgroundPickerGaleryPresented = false
//    @State private var showSheet = false
//    @State var selectedBackground: UIImage?
//    @State var isBackgroundPickerPresented = false
//    var body: some View {
//        NavigationStack{
//            VStack{
//                if let selectedBackground = selectedBackground {
//                    Image(uiImage: selectedBackground)
//                        .resizable()
//                    .scaledToFill()
//                    .frame(width: 393, height: 393)
//                    .clipped()
//                    .shadow(radius: 5)
//                    .cornerRadius(25)
//                } else {
//                    Image("backgroundImage")
//                        .resizable()
//                    .scaledToFill()
//                    .frame(width: 393, height: 393)
//                    .clipped()
//                    .shadow(radius: 5)
//                    .cornerRadius(25)
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
//            .navigationTitle("capa")
//            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showSheet = true
//                      
//                    }, label: {
//                        Text("editar")
//                            .foregroundStyle(Color.verdePrincipal)
//                    })
//                    .sheet(isPresented: $showSheet) {
//                        VStack {
//                            Text("editar_foto")
//                                .font(.headline)
//                                .padding()
//
//                            Divider()
//                            Button(action: {
//                                isBackgroundPickerPresented = true
//                            }, label: {
//                                HStack {
//                                    Text("tirar_foto")
//                                    Spacer()
//                                    Image(systemName: "camera")
//                                    
//                                }
//                                .padding()
//                            })
//                            .sheet(isPresented: $isBackgroundPickerPresented) {
//                                ImagePicker2(selectedBackground: $selectedBackground, sourceType: .camera)
//                            }
//                            Divider()
//                            Button(action: {
//                                isBackgroundPickerGaleryPresented = true
//                            }, label: {
//                                HStack {
//                                    Text("escolher_foto")
//                                    Spacer()
//                                    Image(systemName: "photo")
//                                }
//                                .padding()
//                            })
//                            .sheet(isPresented: $isBackgroundPickerGaleryPresented) {
//                                ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
//                            }
//                            Divider()
//
//                            // Opção para apagar foto
//                            Button(action: {
//                                
//                            }, label: {
//                                HStack {
//                                    Text("apagar_foto")
//                                        .foregroundColor(.red)
//                                    Spacer()
//                                    Image(systemName: "trash")
//                                    
//                                }
//                                
//                            })
//                            .padding()
//                           
//                                Spacer()
//                            }
//                        
//                        .padding()
//                        .presentationDetents([.fraction(0.4), .medium])
//                      
//                    }
//                }
//                ToolbarItem(placement: .bottomBar) {
//                    Button(action:{
////                        context.delete(selectedImage)
//                        selectedBackground = nil
//                        
//                    }, label: {
//                        ZStack{
////                            Rectangle()
////                                .frame(width: 70, height: 45)
////                                .foregroundColor(.gray)
////                                .opacity(0.2)
////                                .cornerRadius(10)
//                                    
//                            Image(systemName: "trash")
//                                .foregroundStyle(.red)
//                        }
//                      })
//                  }
//            }
//        }
//    }
//}
//
//#Preview {
//    BackgroundImageView()
//}
///*.sheet(isPresented: $isBackgroundPickerPresented) {
//    ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
//}
//*/
