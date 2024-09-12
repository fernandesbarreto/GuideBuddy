//
//  AddDoc.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.

import SwiftUI
import PDFKit
import SwiftData

@Model
class ItemEntity: Identifiable {
    var id = UUID()
    var type: Int
    var imageData: Data?
    var pdfPath: String?
    var area: String

    init(type: Int, imageData: Data? = nil, pdfPath: String? = nil, area: String) {
        self.type = type
        self.imageData = imageData
        self.pdfPath = pdfPath
        self.area = area
    }
}

struct AdicionarDocumento: View {
    @Environment(\.modelContext) private var context: ModelContext
    let documento: Documento
    @State private var isImporting = false
    @State private var fileURL: URL? = nil
    @Query private var allItems: [ItemEntity]
    @State private var selectedItem: ItemEntity? = nil
    @State private var showingConfirmation = false
    @State private var activityItems: [Any] = []
    @State private var isShowingShareSheet = false
    
    var filteredItems: [ItemEntity] {
        allItems.filter { entity in
            entity.area == documento.titulo
        }
    }
    
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
                        
                        ForEach(filteredItems, id: \.id) { item in
                            if item.type == 0, let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                                buildImageMenu(item: item, uiImage: uiImage)
                            } else if item.type == 1 {
                                buildPDFMenu(item: item)
                            }
                        }
                    }
                }
                .padding(24)
            }
            .fileImporter(isPresented: $isImporting, allowedContentTypes: [.pdf, .image]) { result in
                handleFileImport(result: result)
            }
            .navigationTitle("Detalhes")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedItem) { item in
                if item.type == 0, let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                    ImageView(image: uiImage)
                } else if item.type == 1, let pdfPath = item.pdfPath {
                    PDFViewWrapper(pdfPath: pdfPath)
                }
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ActivityView(activityItems: activityItems)
            }
        }
    }
    
    private func buildImageMenu(item: ItemEntity, uiImage: UIImage) -> some View {
        Menu {
            Button(action: {
                selectedItem = item
            }) {
                Label("Visualizar", systemImage: "eye")
            }
            Button(action: {
                activityItems = [uiImage]
                isShowingShareSheet = true
            }) {
                Label("Compartilhar", systemImage: "square.and.arrow.up")
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
                deleteItem(item: item)
                showingConfirmation = false
            }
        }
    }

    private func buildPDFMenu(item: ItemEntity) -> some View {
        Menu {
            Button(action: {
                selectedItem = item
            }) {
                Label("Visualizar", systemImage: "eye")
            }
            Button(action: {
                if let pdfPath = item.pdfPath {
                    let fileManager = FileManager.default
                    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent(pdfPath)
                    activityItems = [fileURL]
                    isShowingShareSheet = true
                }
            }) {
                Label("Compartilhar", systemImage: "square.and.arrow.up")
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
                deleteItem(item: item)
                showingConfirmation = false
            }
        }
    }

    
    private func handleFileImport(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            self.fileURL = url
            _ = url.startAccessingSecurityScopedResource()
            if url.pathExtension == "pdf" {
                savePDFToSwiftData(url: url)
            } else {
                if let data = try? Data(contentsOf: url),
                   let _ = UIImage(data: data) {
                    saveImageToSwiftData(imageData: data)
                }
            }
        case .failure(let error):
            print("Erro ao importar o arquivo: \(error.localizedDescription)")
        }
    }

    private func saveImageToSwiftData(imageData: Data) {
        let newItem = ItemEntity(type: 0, imageData: imageData, area: documento.titulo)
        context.insert(newItem)
        try? context.save()
    }
    
    private func savePDFToSwiftData(url: URL) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        
        do {
            if !fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.copyItem(at: url, to: destinationURL)
            }
            let newItem = ItemEntity(type: 1, pdfPath: destinationURL.lastPathComponent, area: documento.titulo)
            context.insert(newItem)
            try context.save()
            print("Saved file at: \(destinationURL.path)")
        } catch {
            print("Failed to copy file: \(error.localizedDescription)")
        }
    }


    private func deleteItem(item: ItemEntity) {
        context.delete(item)
        try? context.save()
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
    let pdfPath: String

    var body: some View {
        PDFKitView(pdfPath: pdfPath)
            .navigationTitle("Visualizar PDF")
            .padding(.top, 16)
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfPath: String

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(pdfPath)

        if let document = PDFDocument(url: fileURL) {
            pdfView.document = document
        } else {
            print("Failed to load PDF at path: \(fileURL.path)")
        }
        
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // aq eh só um stub pra conformar com a classe
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
