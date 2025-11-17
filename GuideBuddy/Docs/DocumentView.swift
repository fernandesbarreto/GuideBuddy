//
//  DocumentView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 20/09/24.
//

import SwiftUI
import SwiftData

struct DocumentDetailView: View {
    var item: ItemEntity
    @Environment(\.modelContext) private var context
    @State private var showingConfirmation = false
    @State private var shareableItems: ShareableItems? = nil
    @Query private var allItems: [ItemEntity]
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
                if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .scaleEffect(scale)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    self.scale = value
                                }
                        )
                    
                }
                else if let pdfPath = item.pdfPath {
                 
                        
                        PDFViewWrapper(pdfPath: pdfPath)
                        
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                            .foregroundStyle(.white)
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
           
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("detalhes".localized)
            .navigationBarItems(trailing: Button(action: {
                shareDocument()
                      }) {
                          Image(systemName: "square.and.arrow.up")
                              .foregroundColor(Color.verdePrincipal)
                      })
            .sheet(item: $shareableItems) { shareable in
                ActivityView(activityItems: shareable.items)
            }
                      .toolbar {
                          Button(action:{
                              showingConfirmation = true
                          }, label: {
                              Image(systemName: "trash")
                                  .foregroundColor(Color.red)
                          })
                          
                      }
                      .confirmationDialog("excluir_da_lista".localized, isPresented: $showingConfirmation, titleVisibility: .visible) {
                          Button("cancelar".localized, role: .cancel) {
                              showingConfirmation = false
                          }
                          Button("sim_excluir".localized, role: .destructive) {
                              deleteItem(item: item)
                              showingConfirmation = false
                          }
                      }
    }
    
    // MARK: - Funções auxiliares
    private func shareDocument() {
        var itemsToShare: [Any] = []
        
        // Se for imagem
        if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
            itemsToShare = [uiImage]
        }
        // Se for PDF
        else if let pdfPath = item.pdfPath {
            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(pdfPath)
            
            // Verifica se o arquivo existe
            if fileManager.fileExists(atPath: fileURL.path) {
                itemsToShare = [fileURL]
            } else {
                print("❌ Erro: Arquivo PDF não encontrado em: \(fileURL.path)")
                return
            }
        }
        
        // Define os items (isso automaticamente abre o sheet)
        if !itemsToShare.isEmpty {
            shareableItems = ShareableItems(items: itemsToShare)
        }
    }
    
    private func deleteItem(item: ItemEntity) {
        context.delete(item)
        do {
            try context.save()
            print("✅ Item deletado com sucesso")
        } catch {
            print("❌ Erro ao deletar item: \(error)")
        }
    }
}







