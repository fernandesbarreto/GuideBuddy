//
//  Profile.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData

@Model
class Photo {
    var profilePhoto: Photo
  
    
    init(profilePhoto: Photo) {
        self.profilePhoto = profilePhoto
       
    }
}

struct Profile: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var selectedBackground: UIImage?
    @State private var isBackgroundPickerPresented = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ZStack {
                        if let selectedBackground = selectedBackground {
                            // Exibe a imagem capturada para a capa
                            Image(uiImage: selectedBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 393, height: 253)
                                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                .clipped()
                                .shadow(radius: 5)
                        } else {
                            // Exibe um placeholder quando nenhuma imagem de capa é selecionada
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: 393, height: 253)
                                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                .overlay(
                                    Text("Toque para selecionar capa")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .padding()
                                )
                                .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            isBackgroundPickerPresented = true
                        }) {
                            // Botão invisível sobre a imagem para selecionar nova capa
                            Color.clear.frame(width: 393, height: 253)
                        }
                        .sheet(isPresented: $isBackgroundPickerPresented) {
                            // Apresenta o ImagePicker quando o botão é pressionado
                            ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
                        }
                    }
//                    .offset(y: -30)
                    Spacer()
                        .frame(height: 20) // Espaçamento entre capa e foto de perfil
                    VStack{
                        ZStack {
                            Circle()
                                .foregroundStyle(Color.white)
                                .frame(width: 120, height: 120)
                            if let selectedImage = selectedImage {
                                // Exibe a imagem capturada para o perfil
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 106, height: 106)
                                    .clipShape(Circle())
                            } else {
                                // Exibe um placeholder quando nenhuma imagem de perfil é selecionada
                                Image("profileImage")
                                    .resizable()
                                    .frame(width: 106, height: 106)
                                    .scaledToFill()
                                    .clipShape(Circle())
                            }
                            
                            Button(action: {
                                isImagePickerPresented = true
                            }) {
                                // Botão invisível sobre a imagem para selecionar nova foto de perfil
                                Color.clear.frame(width: 106, height: 106)
                            }
                            .sheet(isPresented: $isImagePickerPresented) {
                                // Apresenta o ImagePicker quando o botão é pressionado
                                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
                            }
                        }
                   
                        VStack {
                            Text("Pedro Nunes")
                                .font(.system(size: 24,weight: .regular , design: .rounded))
                            .padding(.top, 10)
                            
                            Text("29")
                                .font(.system(size: 24,weight: .regular , design: .rounded))
                                .padding(.top, 2)
                        }
                    }
                    .offset(y: -78)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Profile")
            
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {}, label: {
//                        Image(systemName: "")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30)
//                    })
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(Color.verdePrincipal)
                    })
                }
            }
        }
        
    }
    
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    Profile()
}
