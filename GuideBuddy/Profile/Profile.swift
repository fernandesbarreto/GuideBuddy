//
//  Profile.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData

@Model
class Photos {
    var profilePhoto: String
    var backgroundPhoto: String
    
    init(backgroudPhoto: String, profilePhoto: String) {
        self.backgroundPhoto = backgroudPhoto
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
                        NavigationLink(destination: BackgroundImageView(), label: {
                        if let selectedBackground = selectedBackground {
                            Image(uiImage: selectedBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 393, height: 300)
                                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                .clipped()
                                .shadow(radius: 5)
                        } else {
                            // Exibe um placeholder quando nenhuma imagem de capa é selecionada
                            Image("backgroundImage")
                                .frame(width: 393, height: 300)
                                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                            //                                .overlay(
                            //                                    Text("Toque para selecionar capa")
                            //                                        .font(.title2)
                            //                                        .foregroundColor(.white)
                            //                                        .padding()
                            //                                )
                                .shadow(radius: 5)
                        }
                           
                        })
                        
//
//                        Button(action: {
//                            isBackgroundPickerPresented = true
//                        }) {
//                            // Botão invisível sobre a imagem para selecionar nova capa
//                            Color.clear.frame(width: 393, height: 253)
//                        }
//                        .sheet(isPresented: $isBackgroundPickerPresented) {
//                            // Apresenta o ImagePicker quando o botão é pressionado
//                            ImagePicker2(selectedBackground: $selectedBackground, sourceType: .photoLibrary)
//                        }
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
                                NavigationLink(destination: {
                                    ProfilePhotoView()
                                }, label: {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 106, height: 106)
                                        .clipShape(Circle())
                                })
                               
                            } else {
                                NavigationLink(destination: {
                                    ProfilePhotoView()
                                }, label: {  Image("profileImage")
                                    
                                        .frame(width: 106, height: 106)
                                        .scaledToFill()
                                        .clipShape(Circle())})
                             
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
                .offset(y:-110)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("perfil")
            .toolbar {
//                ToolbarItem(placement: .principal) {
//                  Text("Perfil")
//                        .foregroundStyle(.white)
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Text("editar")
                            .foregroundStyle(Color.background)
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
        Profile()
    }
}

#Preview {
    Profile()
}
