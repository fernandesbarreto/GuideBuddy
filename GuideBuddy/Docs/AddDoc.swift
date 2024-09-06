//
//  AddDoc.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.


import SwiftUI

struct Item: Identifiable, Hashable {
    let id = UUID()
    let type: Int
    let selectedImage: UIImage?
    let pdf: String?
}


struct AdicionarDocumento: View {
    let documento: Documento
    @State private var isImporting = false
    @State private var fileURL: URL? = nil // Armazena a URL do arquivo importado
    @State private var fileContent: String = "" // Armazena o conteúdo do arquivo
    
    
    @State private var items: [Item] = []
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(documento.titulo)
                    .font(.headline)
                    .padding(24)
                
                ScrollView {
                    LazyVGrid(columns: [ GridItem(.fixed(100)),
                                         GridItem(.fixed(100)),
                                         GridItem(.fixed(100))]) {
                        
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
                            // nesse momento, eu posso fazer o que eu quiser com o item
                            if item.type == 0 {
                                
                                if let uiImage = item.selectedImage {
                                    
                                    Button(action: {
                                    }) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                }
                                
                            }
                            else if item.type == 1 {
                                Image("pdfImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                        
                    }
                }
            }
            
            //                if let fileURL = fileURL {
            //                    Text("Arquivo Importado: \(fileURL.lastPathComponent)")
            //                        .padding()
            //                }
            
            if !fileContent.isEmpty {
                Text("Conteúdo do Arquivo:")
                    .font(.headline)
                    .padding(.top)
                Text(fileContent)
                    .padding()
            }
        }
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.pdf, .image]) { result in
            switch result {
            case .success(let url):
                
                self.fileURL = url
                
               _ = url.startAccessingSecurityScopedResource() // mesmo com infoplist tem que permitir aqui
                
                if fileURL!.pathExtension == "pdf" {
                    do {
                       
                        let data = try Data(contentsOf: url)
                        self.items.append(Item(type: 1, selectedImage: nil, pdf: fileURL!.lastPathComponent))
                        print("Conteúdo do arquivo importado: \(data)")
                    } catch {
                        print("Erro ao ler o arquivo: \(error.localizedDescription)")
                    }
                    
                } else { // se for qualquer tipo de imagem
                    do {
                        let data = try Data(contentsOf: url)
                        let img = UIImage(data: data)
                        self.items.append(Item(type: 0, selectedImage: img, pdf: nil))
                    } catch {
                        print("Erro ao processar arquivo: \(error.localizedDescription)")
                    }
                }
                
                
            case .failure(let error):
                print("Erro ao importar o arquivo: \(error.localizedDescription)")
            }
        }
                      .navigationTitle("Detalhes")
                      .navigationBarTitleDisplayMode(.inline)
        
    }
}




func read(from url: URL) throws -> String {
    return try String(contentsOf: url, encoding: .utf8)
}




struct AdicionarDocumento_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarDocumento(documento: Documento(titulo: "Passaporte"))
    }
}
