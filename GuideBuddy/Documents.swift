//
//  Documents.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 08/09/24.
//

import SwiftUI

struct Documents: View {
    @EnvironmentObject var languageManager: LanguageManager
    
    var documentos: [Documento] {
        [
            Documento(titulo: "passaporte".localized),
            Documento(titulo: "comprovante_de_residencia".localized),
            Documento(titulo: "carta_aceite".localized),
            Documento(titulo: "passagens".localized),
            Documento(titulo: "comprovante_fincanceiro".localized),
            Documento(titulo: "visto_de_estudo".localized),
            Documento(titulo: "carta_de_indicacao".localized),
            Documento(titulo: "cpf".localized),
            Documento(titulo: "historico_escolar".localized),
            Documento(titulo: "laudo_medico".localized)
        ]
    }
    
    var body: some View {
        List(documentos) { doc in
            NavigationLink(destination: AdicionarDocumento(documento: doc)) {
                Text(doc.titulo)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("documento".localized)
    }
    
}

struct Documento: Identifiable {
    let id: UUID
    let titulo: String
    
    init(titulo: String) {
        self.id = UUID()
        self.titulo = titulo
    }
}

#Preview {
    Documents()
}
