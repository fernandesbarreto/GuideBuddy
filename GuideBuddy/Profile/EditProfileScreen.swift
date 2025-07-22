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
                    Section(header: Text("profile_pic")) {
                        NavigationLink(destination: {
                            ProfilePhotoView(selectedImage: selectedImage)
                        }, label: {
                            HStack {
                                
                                    if let selectedImage = selectedImage {
                                        Image(uiImage: selectedImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    } else {
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
                    Section(header: Text("user_name")) {
                        TextField(user.first?.name ?? "Usuário", text: $nome)
                        
                                .onChange(of: nome) { newValue in
                                    if let firstUser = user.first {
                                        firstUser.name = newValue
                                    }
                                }
                               
                    }
                    Section(header: Text("user_age")) {
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
                                AgePickerView(selectedAge: $selectedAge)
                                    .onAppear {
                                        if let firstUser = user.first {
                                            selectedAge = firstUser.age
                                        }
                                    }
                                    .onDisappear {
                                        if let firstUser = user.first {
                                           
                                            firstUser.age = selectedAge
                                           
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

                             }
                        .sheet(isPresented: $showLanguagePicker) {
                            LanguagePicker(selectedLanguage: $selectedLanguage)
                                .presentationDetents([.fraction(0.5), .medium])
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.regularMaterial)
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
