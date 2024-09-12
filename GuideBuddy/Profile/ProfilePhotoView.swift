//
//  ProfilePhotoView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
//

import SwiftUI


struct ProfilePhotoView: View {
    @State var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isImagePickerGaleryPresented = false
    @State private var selectedBackground: UIImage?
    @State private var isBackgroundPickerPresented = false
    @State private var showSheet = false
    var body: some View {
        NavigationStack{
            VStack{
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                    .scaledToFill()
                    .frame(width: 393, height: 393)
                    .clipped()
                    .shadow(radius: 5)
                    .cornerRadius(25)
                } else {
                    ZStack{
                        Rectangle()
                            .frame(width: 393, height: 393)
                            .foregroundColor(Color.verdePrincipal)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                        Image("profileImage2")
                            .frame(width: 200, height: 200)
                            
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .navigationTitle("profile_pic")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet = true
                    }, label: {
                        Text("editar")
                            .foregroundStyle(Color.verdePrincipal)
                    })
                    .sheet(isPresented: $showSheet) {
                        VStack {
                            Text("editar_foto")
                                .font(.headline)
                                .padding()
                            
                            Divider()
                            Button(action: {
                                isImagePickerPresented = true
                            }, label: {
                                HStack {
                                    Text("tirar_foto")
                                    Spacer()
                                    Image(systemName: "camera")
                                    
                                }
                                .padding()
                            })
                            .sheet(isPresented: $isImagePickerPresented) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                            }
                            Divider()
                            Button(action: {
                                isImagePickerGaleryPresented = true
                            }, label: {
                                HStack {
                                    Text("escolher_foto")
                                    Spacer()
                                    Image(systemName: "photo")
                                }
                                .padding()
                            })
                            .sheet(isPresented: $isImagePickerGaleryPresented) {
                                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                            }
                            Divider()
                            Button(action: {
                            }, label: {
                                HStack {
                                    Text("apagar_foto")
                                        .foregroundColor(.red)
                                    Spacer()
                                    Image(systemName: "trash")
                                    
                                }
                                
                            })
                            .padding()
                            
                            Spacer()
                        }
                        
                        .padding()
                        .presentationDetents([.fraction(0.4), .medium])
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    ProfilePhotoView()
}
