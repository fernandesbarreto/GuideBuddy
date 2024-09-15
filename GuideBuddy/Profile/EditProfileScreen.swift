//
//  EditProfileScreen.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 06/09/24.
//

import SwiftUI
import SwiftData

struct EditProfileScreen: View {
 
        @State var selectedImage: UIImage?
        @State private var isImagePickerPresented = false
        @State private var selectedBackground: UIImage?
        @State private var isBackgroundPickerPresented = false
        @State private var isPhotoPickerPresented = false
        @State private var showSheet = false
    @State private var nome = ""
    @State private var idade = "29"
    @State private var showAgePicker = false
    @State private var selectedAge = 18
    @State private var selectedLanguage = "Português"
    @State private var showLanguagePicker = false
    @Query private var profilePhotos: [ProfilePhoto]
    @Query private var user: [User]
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    // Primeiro grupo com título (para edição da foto do perfil)
                    Section(header: Text("profile_pic")) {
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
                    Section(header: Text("user_name")) {
                        TextField(user.first?.name ?? "Usuário", text: $nome)
                        
                                .onChange(of: nome) { newValue in
                                    if let firstUser = user.first {
                                        // Atualize o nome do primeiro usuário
                                        firstUser.name = newValue
                                        // Salve as alterações no banco de dados, se necessário (ex. Core Data)
                                    }
                                }
                               
                    }
                    Section(header: Text("user_age")) {
                       /* TextField("Idade", text: $idade)*/
                        
                        HStack {
                            Text(String(user[0].age) ?? "24")
                            Spacer()
                            Button(action: {
                                showAgePicker = true
                            }, label: {
                                Text("Editar")
                                    .foregroundStyle(Color.verdePrincipal)
                            })
                            .sheet(isPresented: $showAgePicker) {
                                AgePickerView(selectedAge: $selectedAge) // Aqui o Picker vai alterar 'selectedAge'
                                    .onAppear {
                                        // Inicializar o Picker com a idade atual do usuário
                                        if let firstUser = user.first {
                                            selectedAge = firstUser.age // Atribui a idade atual ao Picker
                                        }
                                    }
                                    .onDisappear {
                                        if let firstUser = user.first {
                                            // Atualiza a idade do primeiro usuário diretamente
                                            firstUser.age = selectedAge
                                            
                                            // Se estiver usando SwiftData, o banco de dados deve ser atualizado automaticamente
                                            // Se estiver usando CoreData ou outro sistema, você pode precisar salvar manualmente aqui
                                        }
                                    }
                            }
                            }
                        }
                    Section(header: Text("linguagem")) {
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
            .navigationTitle("editar_perfil")
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

//#Preview {
//    EditProfileScreen()
//}
