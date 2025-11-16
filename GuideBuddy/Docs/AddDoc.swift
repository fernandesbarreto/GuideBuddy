//
//  AddDoc.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.
//

import SwiftUI
import PDFKit
import SwiftData
import UIKit

@Model
class ItemEntity: Identifiable {
    var id = UUID()
    var type: Int
    var imageData: Data?
    var pdfPath: String?
    var area: String
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \User.documents) var owner: User?

    init(type: Int, imageData: Data? = nil, pdfPath: String? = nil, area: String, name: String, owner: User? = nil) {
        self.type = type
        self.imageData = imageData
        self.pdfPath = pdfPath
        self.area = area
        self.name = name
        self.owner = owner
    }
}

struct AdicionarDocumento: View {
    @Environment(\.modelContext) private var context: ModelContext
    let documento: Documento
    @State private var isImporting = false
    @Query private var users: [User]
    @State private var showingConfirmation = false
    @State private var activityItems: [Any] = []
    @State private var isShowingShareSheet = false
    
    var currentUser: User? {
        users.first
    }
    
    var filteredItems: [ItemEntity] {
        guard let user = currentUser else { return [] }
        return user.documents.filter { $0.area == documento.titulo }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(.fixed(120)), GridItem(.fixed(120)), GridItem(.fixed(120))], spacing: 20) {
                        
                        // Botão para adicionar arquivos
                        VStack {
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
                            Text("")
                                .font(.caption)
                        }
                        
                        // Lista de itens já adicionados
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
            .navigationTitle(documento.titulo)
            .navigationBarTitleDisplayMode(.inline)
        }
        // Sheet de compartilhamento
        .sheet(isPresented: $isShowingShareSheet, onDismiss: {
            activityItems = [] // Limpa os itens ao fechar
        }) {
            ActivityView(activityItems: activityItems)
        }
    }
    
    // MARK: - Menus
    private func buildImageMenu(item: ItemEntity, uiImage: UIImage) -> some View {
        Menu {
            NavigationLink(destination: DocumentDetailView(item: item)) {
                Label("visualizar".localized, systemImage: "eye")
            }
            
            Button(action: {
                activityItems = [uiImage]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    isShowingShareSheet = true
                }
            }) {
                Label("compartilhar".localized, systemImage: "square.and.arrow.up")
            }
            
            Button(action: {
                showingConfirmation = true
            }) {
                Label("excluir".localized, systemImage: "trash")
            }
        } label: {
            VStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipped()
                    .cornerRadius(10)
                Text(item.name)
                    .font(.caption)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .confirmationDialog("excluir_da_lista".localized, isPresented: $showingConfirmation, titleVisibility: .visible) {
            Button("cancelar".localized, role: .cancel) { showingConfirmation = false }
            Button("sim_excluir".localized, role: .destructive) {
                deleteItem(item: item)
                showingConfirmation = false
            }
        }
    }
    
    private func buildPDFMenu(item: ItemEntity) -> some View {
        Menu {
            NavigationLink(destination: DocumentDetailView(item: item)) {
                Label("visualizar".localized, systemImage: "eye")
            }
            
            Button(action: {
                if let pdfPath = item.pdfPath {
                    let fileManager = FileManager.default
                    let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent(pdfPath)
                    activityItems = [fileURL]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        isShowingShareSheet = true
                    }
                }
            }) {
                Label("compartilhar".localized, systemImage: "square.and.arrow.up")
            }
            
            Button(action: {
                showingConfirmation = true
            }) {
                Label("excluir".localized, systemImage: "trash")
            }
        } label: {
            VStack {
                Image("pdfImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipped()
                    .cornerRadius(10)
                Text(item.name)
                    .font(.caption)
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .confirmationDialog("excluir_da_lista".localized, isPresented: $showingConfirmation, titleVisibility: .visible) {
            Button("cancelar".localized, role: .cancel) { showingConfirmation = false }
            Button("sim_excluir".localized, role: .destructive) {
                deleteItem(item: item)
                showingConfirmation = false
            }
        }
    }
    
    // MARK: - Importação e Salvamento
    private func handleFileImport(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            _ = url.startAccessingSecurityScopedResource()
            let fileName = url.lastPathComponent
            
            if url.pathExtension == "pdf" {
                savePDFToSwiftData(url: url, fileName: fileName)
            } else if let data = try? Data(contentsOf: url), UIImage(data: data) != nil {
                saveImageToSwiftData(imageData: data, imageName: fileName)
            }
        case .failure(let error):
            print("Erro ao importar o arquivo: \(error.localizedDescription)")
        }
    }
    
    private func saveImageToSwiftData(imageData: Data, imageName: String) {
        guard let user = currentUser else {
            print("Erro: Nenhum usuário encontrado")
            return
        }
        let newItem = ItemEntity(type: 0, imageData: imageData, area: documento.titulo, name: imageName, owner: user)
        user.documents.append(newItem)
        context.insert(newItem)
        do {
            try context.save()
            print("Imagem salva com sucesso para o usuário: \(user.name)")
        } catch {
            print("Erro ao salvar imagem: \(error)")
        }
    }
    
    private func savePDFToSwiftData(url: URL, fileName: String) {
        guard let user = currentUser else {
            print("Erro: Nenhum usuário encontrado")
            return
        }
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        do {
            if !fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.copyItem(at: url, to: destinationURL)
            }
            let newItem = ItemEntity(type: 1, pdfPath: destinationURL.lastPathComponent, area: documento.titulo, name: fileName, owner: user)
            user.documents.append(newItem)
            context.insert(newItem)
            try context.save()
            print("PDF salvo com sucesso para o usuário: \(user.name)")
        } catch {
            print("Failed to copy file: \(error.localizedDescription)")
        }
    }
    
    private func deleteItem(item: ItemEntity) {
        context.delete(item)
        try? context.save()
    }
}

// MARK: - Visualizações Auxiliares
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
    }
}

struct PDFViewWrapper: View {
    let pdfPath: String
    var body: some View {
        PDFKitView(pdfPath: pdfPath)
    }
}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
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
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
