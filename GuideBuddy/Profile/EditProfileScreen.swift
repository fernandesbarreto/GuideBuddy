//
//  EditProfileScreen.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
//

import SwiftUI

struct EditProfileScreen: View {
 
        @State var selectedImage: UIImage?
        @State private var isImagePickerPresented = false
        @State private var selectedBackground: UIImage?
        @State private var isBackgroundPickerPresented = false
        @State private var isPhotoPickerPresented = false
        @State private var showSheet = false
    @State private var nome = "Inicial"
    var body: some View {
        NavigationStack{
            VStack{
                    Group {
                      List {
                          NavigationLink(destination: {
                              ProfilePhotoView(selectedImage: selectedImage)
                          }, label: {
                              
                              HStack {
                                  VStack {
                                      if let selectedImage = selectedImage {
                                          // Exibe a imagem capturada para o perfil
                                          Image(uiImage: selectedImage)
                                              .resizable()
                                              .scaledToFill()
                                              .frame(width: 80, height: 80)
                                              .clipShape(Circle())
                                          
                                          
                                        
                                      } else {
                                          ZStack{
                                              Image("profileImage")
                                                  .resizable()
                                                  .frame(width: 80, height: 80)
                                                  .clipShape(Circle())
                                          }
                                      }
                                      Text("Editar")
                                          .foregroundStyle(Color.verdePrincipal)
                                      
                                
                                  }
                              }
                              
                          })
                          TextField("asd", text: $nome)
                        
                                 
                           
                            }
                        
                      }
                Text("Idade")
                    }
                
                
                
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Editar perfil")
            .toolbar {
//                ToolbarItem(placement: .principal) {
//                  Text("Perfil")
//                        .foregroundStyle(.white)
//                }
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: {
//                        EditProfileScreen()
//                    }, label: {
//                        Text("Editar")
//                            .foregroundStyle(Color.background)
//                    })
//                }
            }
            
        }
    }
}

#Preview {
    EditProfileScreen()
}
