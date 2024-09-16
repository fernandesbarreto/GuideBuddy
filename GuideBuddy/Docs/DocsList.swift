//
//  Docs.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.
//

import SwiftUI

struct ListaDeDocumentosView: View {
    @State var documentos = [
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
            
            .navigationTitle("Documentos")
            .navigationBarTitleDisplayMode(.inline)
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
                                       Text("Adicionar Nova Categoria")
                                           .font(.headline)
                                       TextField("Nome da Categoria", text: $newCategoryName)
                                           .textFieldStyle(RoundedBorderTextFieldStyle())
                                           .padding()
//                                       Button("Adicionar") {
//                                           addCategory(named: newCategoryName)
//                                           isAddingCategory = false // Fechar o sheet após adicionar
//                                       }
                                       Button(action: {
                                           if !newCategoryName.isEmpty {
                                               addCategory(named: newCategoryName)
                                               isAddingCategory = false // Fechar o sheet após adicionar
                                               newCategoryName = "" // Limpar o campo após adicionar
                                           }
                                       }, label: {
                                           ZStack {
                                               Image("slangButton")
                                               Text("Adicionar")
                                                   .foregroundStyle(.white)
                                           }
                                       })

                                       .padding()
                                   }
                                   .padding()
                                   .presentationDetents([.fraction(0.3), .medium])
                               }
            
        }
        
    }
    
    
    // Função para adicionar uma nova categoria (documento)
    private func addCategory(named name: String) {
        let newDocumento = Documento(titulo: name)
        documentos.append(newDocumento)
    }
    
    // Função para mover os documentos
    private func move(from source: IndexSet, to destination: Int) {
        documentos.move(fromOffsets: source, toOffset: destination)
    }
    
    // Função para deletar os documentos
    private func delete(at offsets: IndexSet) {
        documentos.remove(atOffsets: offsets)
    }
}

struct Documento: Identifiable {
    let id = UUID()
    let titulo: String
}


#Preview {
    ListaDeDocumentosView()
}
