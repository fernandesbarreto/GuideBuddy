//
//  AddDoc.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.
//

import SwiftUI


struct AdicionarDocumento: View {
    let documento: Documento
    @State private var isImporting = false
    
    var body: some View {
        Text(documento.titulo)
            .font(.headline)
            .padding(24)
        VStack(alignment: .leading) {
            
            ScrollView{
                LazyVGrid(columns: [.init(), .init(), .init()]) {
                    
                    
                    
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
                    
                    Spacer()
                }}}
        
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.pdf, .image]) { result in
            switch result {
            case .success(let url):
                do {
                    let content = try read(from: url)
                    // Lógica para lidar com o conteúdo do arquivo
                    print("Conteúdo do arquivo importado: \(content)")
                } catch {
                    print("Erro ao ler o arquivo: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Erro ao importar o arquivo: \(error.localizedDescription)")
            }
        }
                      .frame(minWidth: 320)
//                      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                      .padding()
                      .navigationTitle("Detalhes")
                      .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func read(from url: URL) throws -> String {
        // Exemplo de implementação da função read
        return try String(contentsOf: url)
    }
}

struct AdicionarDocumento_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarDocumento(documento: Documento(titulo: "Passaporte"))
    }
}
