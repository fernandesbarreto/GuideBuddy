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
                
                
                Text(building.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
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
                Spacer()
                VStack {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        // Primeiro grupo com título (para edição da foto do perfil)
                        Section(header: Text("Descrição")
                            .font(.body)
                            .bold())
                        {
                            Text(building.description)
                                .font(.body)
                            //                                .padding()
                        }
                        .padding(.horizontal)
                        Section(header: Text("Números")
                            .font(.body)
                            .bold()
                        ) {
                            ForEach(building.cellphoneNumbers, id: \.self) { number in
                                Button(action: {
                                    makeCall(to: number)
                                }) {
                                    Text(number)
                                        .foregroundColor(.blue)
                                        .underline()
                                }
                                Button(action: {}, label: {
                                    Text("Hello")
                                })
                                
                            }
                        }
                        .padding(.horizontal, 15)
                    }
                    
                    
                }
                .navigationTitle(building.navtitle)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
    func makeCall(to number: String) {
        let tel = "tel://\(number)"
        guard let url = URL(string: tel) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
#Preview {
    BuildingDetailView(building: BuildingDetail(title: "Centro de Filosofia e Cências Humanas", description: "O Centro de Filosofia e Ciências Humanas (CFCH), assim denominado a partir de 1974, resultou da fusão de vários departamentos da antiga Faculdade de Filosofia, Ciências e Letras de Pernambuco (FAFIPE), criada em 1950, e do Instituto de Ciências do Homem, inicialmente denominado de Instituto de Filosofia e Ciências Humanas. O Centro é formado por 08 (oito) departamentos – Antropologia e Museologia; Arqueologia; Ciências Geográficas; Sociologia; Ciência Política; Filosofia; História e Psicologia. Edificado em uma área de 25.690 m², além dos departamentos este Centro abriga diversos laboratórios de pesquisa e ensino, como também uma biblioteca setorial.", image: "https://www.ufpe.br/documents/40615/67578/CFCH-camerabaixa.JPG/9398eae5-85d8-4847-9a8b-1e0db9c6fc49?t=1499881089418", navtitle: "CFCH", cellphoneNumbers: ["995215663"]))
}
