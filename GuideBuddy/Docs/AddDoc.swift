//
//  AddDoc.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.

import SwiftUI
import PDFKit

struct Item: Identifiable, Hashable {
    let id = UUID()
    let type: Int
    let selectedImage: UIImage?
    let pdf: URL? // Aqui é para armazenar a URL do PDF diretamente
}

struct AdicionarDocumento: View {
    let documento: Documento
    @State private var isImporting = false
    @State private var fileURL: URL? = nil
    @State private var items: [Item] = []
    @State private var selectedItem: Item? = nil
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(documento.titulo)
                    .font(.headline)
                    .padding(24)
                
                ScrollView {
                    LazyVGrid(columns: [ GridItem(.fixed(120)),
                                         GridItem(.fixed(120)),
                                         GridItem(.fixed(120))], spacing: 20) {
                        
                        Button(action: {
                            isImporting = true
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding(40)
                        }
                        .background(Color(white: 0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                        .foregroundColor(.white)
                        
                        ForEach(Array(items.enumerated()), id: \.element) { index, item in
                            if item.type == 0 {
                                if let uiImage = item.selectedImage {
                                    Menu {
                                        Button(action: {
                                            selectedItem = item
                                        }) {
                                            Label("Visualizar", systemImage: "eye")
                                        }
                                        Button(action: {
                                            showingConfirmation = true
                                        }) {
                                            Label("Excluir", systemImage: "trash")
                                        }
                                    } label: {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 110, height: 110)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                    .confirmationDialog("Excluir da lista?", isPresented: $showingConfirmation, titleVisibility: .visible) {
                                        Button("Cancelar", role: .cancel) {
                                            showingConfirmation = false
                                        }
                                        Button("Sim, excluir", role: .destructive) {
                                            print("item at index \(index)")
                                            items.remove(at: index)
                                            showingConfirmation = false
                                        }
                                    }
                                }
                            } else if item.type == 1 {
                                Menu {
                                    Button(action: {
                                        selectedItem = item
                                    }) {
                                        Label("Visualizar", systemImage: "eye")
                                    }
                                    Button(action: {
                                        showingConfirmation = true
                                    }) {
                                        Label("Excluir", systemImage: "trash")
                                    }
                                } label: {
                                    Image("pdfImage")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 110, height: 110)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                                .confirmationDialog("Excluir da lista?", isPresented: $showingConfirmation, titleVisibility: .visible) {
                                    Button("Cancelar", role: .cancel) {
                                        showingConfirmation = false
                                    }
                                    Button("Sim, excluir", role: .destructive) {
                                        print("item at index \(index)")
                                        items.remove(at: index)
                                        showingConfirmation = false
                                    }
                                }
                            }
                        }
                    }
                }.border(.blue)
                    .padding(24)
                    
            }
            .fileImporter(isPresented: $isImporting, allowedContentTypes: [.pdf, .image]) { result in
                switch result {
                case .success(let url):
                    self.fileURL = url
                    _ = url.startAccessingSecurityScopedResource()
                    if url.pathExtension == "pdf" {
                        self.items.append(Item(type: 1, selectedImage: nil, pdf: url))
                    } else {
                        if let data = try? Data(contentsOf: url),
                           let img = UIImage(data: data) {
                            self.items.append(Item(type: 0, selectedImage: img, pdf: nil))
                        }
                    }
                case .failure(let error):
                    print("Erro ao importar o arquivo: \(error.localizedDescription)")
                }
            }
            .navigationTitle("Detalhes")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedItem) { item in
                if item.type == 0, let uiImage = item.selectedImage {
                    ImageView(image: uiImage)
                } else if item.type == 1, let pdfURL = item.pdf {
                    PDFViewWrapper(pdfURL: pdfURL)
                }
            }
        }
    }
}

struct ImageView: View {
    let image: UIImage

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
        }
        .navigationTitle("Visualizar Imagem")
    }
}

struct PDFViewWrapper: View {
    let pdfURL: URL

    var body: some View {
        PDFKitView(pdfURL: pdfURL)
            .navigationTitle("Visualizar PDF")
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfURL: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        pdfView.autoScales = true // Ajusta o zoom automaticamente
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}


