//
//  Docs.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.
//

import SwiftUI
import SwiftData

struct ListaDeDocumentosView: View {
    @Query private var user: [User]
    @State var documentos: [Documento] = [
        Documento(titulo: "Passaporte"),
        Documento(titulo: "Comprovante de residência"),
        Documento(titulo: "Carta de aceite universitário"),
        Documento(titulo: "Passagens"),
        Documento(titulo: "Comprovante financeiro"),
        Documento(titulo: "Visto de Estudo"),
        Documento(titulo: "Carta de Indicação"),
        Documento(titulo: "CPF"),
        Documento(titulo: "Histórico Escolar"),
        Documento(titulo: "Laudos Médicos")
    ]

    @Query private var itemEntity: [ItemEntity]
    
    @State private var isAddingCategory = false
    @State private var newCategoryName = ""
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(documentos) { doc in
                        NavigationLink(destination: AdicionarDocumento(documento: doc)) {
                            Text(doc.titulo)
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move) // Permite mover itens
                }
            }
            .toolbarBackground(.regularMaterial)
            .navigationTitle("documentos".localized)
//            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                          isAddingCategory = true
                      }) {
                          Image(systemName: "plus")
                              .foregroundColor(Color.verdePrincipal)
                      })
                      .toolbar {
                          EditButton()
                              .foregroundColor(Color.verdePrincipal)
                      }
                      .sheet(isPresented: $isAddingCategory) {
                                   VStack {
                                       Text("adicionar_nova_categoria".localized)
                                           .font(.headline)
                                       TextField("nome_da_categoria".localized, text: $newCategoryName)
                                           .textFieldStyle(RoundedBorderTextFieldStyle())
                                           .padding()
//                                       Button("Adicionar") {
//                                           addCategory(named: newCategoryName)
//                                           isAddingCategory = false // Fechar o sheet após adicionar
//                                       }
                                       Button(action: {
                                           if !newCategoryName.isEmpty {
                                               addCategory(named: newCategoryName)
                                               isAddingCategory = false 
                                               newCategoryName = ""
                                           }
                                       }, label: {
                                           ZStack {
                                               Image("slangButton")
                                               Text("adicionar".localized)
                                                   .foregroundStyle(.white)
                                           }
                                       })

                                       .padding()
                                   }
                                   .padding()
                                   .presentationDetents([.fraction(0.3), .medium])
                               }
                      .background(.regularMaterial)
            
        }.onAppear() {
            documentos = (user.last?.documentos ?? []).map({ title in
                return Documento(titulo: title)
            })
        }
        
    }
    
    
    
    private func addCategory(named name: String) {
        let newDocumento = Documento(titulo: name)
        user.last?.documentos.append(newDocumento.titulo)
        documentos.append(newDocumento)
    }
    
   
    private func move(from source: IndexSet, to destination: Int) {
        documentos.move(fromOffsets: source, toOffset: destination)
        user.last?.documentos.move(fromOffsets: source, toOffset: destination)
    }
    
    
    private func delete(at offsets: IndexSet) {
        documentos.remove(atOffsets: offsets)
        user.last?.documentos.remove(atOffsets: offsets)
    }
}

struct Documento: Identifiable {
    let id = UUID()
    let titulo: String
    var imageData: Data? = nil
       var pdfPath: String? = nil
}


#Preview {
    ListaDeDocumentosView()
}
