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
    @State private var showingConfirmation = false
    @State private var activityItems: [Any] = []
    @State private var isShowingShareSheet = false
    @Query private var allItems: [ItemEntity]
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        NavigationStack{
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
            .toolbarBackground(.regularMaterial)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Detalhes")
            .navigationBarItems(trailing: Button(action: {
//                activityItems = [uiImage]
                isShowingShareSheet = true
                      }) {
                          Image(systemName: "square.and.arrow.up")
                              .foregroundColor(Color.verdePrincipal)
                      })
            .sheet(isPresented: $isShowingShareSheet) {
                ActivityView(activityItems: activityItems)
            }
                      .toolbar {
                          Button(action:{
                              showingConfirmation = true
                          }, label: {
                              Image(systemName: "trash")
                                  .foregroundColor(Color.red)
                          })
                          
                      }
                      .confirmationDialog("Excluir da lista?", isPresented: $showingConfirmation, titleVisibility: .visible) {
                          Button("Cancelar", role: .cancel) {
                              showingConfirmation = false
                          }
                          Button("Sim, excluir", role: .destructive) {
//                              deleteItem(item: item)
                              showingConfirmation = false
                          }
                      }
        }
    }
}







