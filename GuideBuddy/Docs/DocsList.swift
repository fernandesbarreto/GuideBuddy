//
//  Docs.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 28/08/24.
//

import SwiftUI

struct ListaDeDocumentosView: View {
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
        NavigationView {
            List(documentos) { doc in
                NavigationLink(destination: AdicionarDocumento(documento: doc)) {
                    Text(doc.titulo)
                }
            }
            .navigationTitle("Documentos")
        }
    }
}

struct Documento: Identifiable {
    let id = UUID()
    let titulo: String
}

#Preview {
    ListaDeDocumentosView()
}
