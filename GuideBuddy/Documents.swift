//
//  Documents.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import SwiftUI

struct Documents: View {
    let documentos = [
    
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
    
    var body: some View {
        NavigationStack{
            List(documentos) { doc in
                NavigationLink(destination: AdicionarDocumento(documento: doc)) {
                    Text(doc.titulo)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Documentos")
            
        }
    }
    
}

struct Documento: Identifiable {
    let id = UUID()
    let titulo: String
}

#Preview {
    Documents()
}
