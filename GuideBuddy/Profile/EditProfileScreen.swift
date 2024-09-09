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
    @State private var nome = "Pedro Nunes"
    @State private var idade = "29"
    @State private var showAgePicker = false
    @State private var selectedAge = 18
    @State private var selectedLanguage = "Português"
    @State private var showLanguagePicker = false
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    // Primeiro grupo com título (para edição da foto do perfil)
                    Section(header: Text("Foto de Perfil")) {
                        NavigationLink(destination: {
                            ProfilePhotoView(selectedImage: selectedImage)
                        }, label: {
                            HStack {
                                
                                    if let selectedImage = selectedImage {
                                        // Exibe a imagem capturada para o perfil
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    } else {
                                        // Imagem padrão
                                        ZStack {
                                            Image("profileImage")
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                        }
                                    }
                                Spacer()
                                    Text("Editar")
                                        .foregroundStyle(Color.verdePrincipal)
                                
                            }
                        })
                    }
                    
                    // Segundo grupo com título (campos de texto)
                    Section(header: Text("Nome")) {
                        TextField("Nome", text: $nome)
                    }
                    Section(header: Text("Idade")) {
                       /* TextField("Idade", text: $idade)*/
                        
                        HStack {
                            Text("\(selectedAge)")
                            Spacer()
                            Button(action: { 
                                showAgePicker = true}, label: {
                                    Text("Editar")
                                        .foregroundStyle(Color.verdePrincipal)
                                })
                                 // Aciona a apresentação do modal
                             }
                             .sheet(isPresented: $showAgePicker) {
                                 AgePickerView(selectedAge: $selectedAge)  // Exibe o Picker como um modal
                                     .presentationDetents([.fraction(0.5), .medium])
                             }
   
                    }
                    Section(header: Text("Linguagem")) {
                        HStack {
                            Text("\(selectedLanguage)")
                            Spacer()
                            Button(action: {
                                showLanguagePicker = true}, label: {
                                    Text("Editar")
                                        .foregroundStyle(Color.verdePrincipal)
                                })
                                 // Aciona a apresentação do modal
                             }
                        .sheet(isPresented: $showLanguagePicker) {
                            LanguagePicker(selectedLanguage: $selectedLanguage)  // Exibe o Picker como um modal
                                .presentationDetents([.fraction(0.5), .medium])
                        }
                    }
                }
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
