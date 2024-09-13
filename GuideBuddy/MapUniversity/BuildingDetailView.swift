//
//  BuildingDetailView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 13/09/24.
//

import SwiftUI

struct BuildingDetailView: View {
    var building: BuildingDetail
    let specificBuilding = allBuildings[0]
    @State var places: [BuildingDetail] = allBuildings
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                
                HStack {
                    Text(building.title)
                        .font(.title)
                    .padding(.top)
                    Spacer()
                }
                .padding(.leading, 15)
                
                AsyncImage(url: URL(string: building.image)) { image in
                    image
                        .resizable()      // Agora o modificador resizable é aplicado à imagem carregada
                        .resizable()
                        .scaledToFill()
                        .frame(width: 370)
                        
                } placeholder: {
                    // Placeholder enquanto a imagem carrega
                    ProgressView()
                }
                
                Text(building.description)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .navigationTitle(building.navtitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
#Preview {
    BuildingDetailView(building: BuildingDetail(title: "Centro de Filosofia e Cências Humanas", description: "O Centro de Filosofia e Ciências Humanas (CFCH), assim denominado a partir de 1974, resultou da fusão de vários departamentos da antiga Faculdade de Filosofia, Ciências e Letras de Pernambuco (FAFIPE), criada em 1950, e do Instituto de Ciências do Homem, inicialmente denominado de Instituto de Filosofia e Ciências Humanas. O Centro é formado por 08 (oito) departamentos – Antropologia e Museologia; Arqueologia; Ciências Geográficas; Sociologia; Ciência Política; Filosofia; História e Psicologia. Edificado em uma área de 25.690 m², além dos departamentos este Centro abriga diversos laboratórios de pesquisa e ensino, como também uma biblioteca setorial.", image: "https://www.ufpe.br/documents/40615/67578/CFCH-camerabaixa.JPG/9398eae5-85d8-4847-9a8b-1e0db9c6fc49?t=1499881089418", navtitle: "CFCH"))
}
