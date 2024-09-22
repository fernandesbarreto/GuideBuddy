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
    @State var showNumbersSheet = false
    @State var showEmailSheet = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                AsyncImage(url: URL(string: building.image)) { image in
                    image
                        .resizable()
                    //                        .resizable()
                        .scaledToFit()
                    //                        .frame(width: 370)
                    //
                } placeholder: {
                    
                    ProgressView()
                }
                .cornerRadius(10.0)
                .frame(width: 393, height: 267)
                .clipped()
                .offset(y: -8)
                Text(building.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.leading, 15)
             
            
                VStack {
                    LazyVStack(alignment: .leading, spacing: 15) {
                        
                        Section() {
                            
                            //                        NavigationLink(
                            //                            destination: SearchableMap(location: SavedLocation(name: building.title, latitude:building.latitude, longitude: building.longitude)),
                            //                            label: {
                            //                                HStack {
                            //                                    Image(systemName: "location.fill")
                            //                                        .foregroundStyle(Color.verdePrincipal)
                            //                                    Text(building.location) // Aqui pode ser o nome da localização ou algo mais descritivo
                            //                                        .multilineTextAlignment(.leading)
                            //                                        .foregroundStyle(Color.gray)
                            //                                }
                            //                            }
                            //                        )
                            
                        }
                        .padding(.horizontal)
                        //                        .padding(.bottom)
                        Section(header: Text("Contatos")
                            .font(.body)
                            .bold()){
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack{
                                        Button(action: {
                                            showNumbersSheet = true
                                        }, label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 175, height: 70)
                                                    .cornerRadius(15)
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.1)
                                                    .shadow(radius: 5)
                                                VStack {
                                                    Image(systemName: "phone.fill")
                                                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                                                        .foregroundStyle(Color.verdePrincipal)
                                                        .opacity(0.8)
                                                    
                                                    Text("Telefone")
                                                        .font(.system(size: 12))
                                                        .bold()
                                                        .foregroundStyle(Color.verdePrincipal)
                                                        .padding(.vertical, 3)
                                                        .opacity(0.8)
                                                }
                                            }
                                        })
                                        .sheet(isPresented: $showNumbersSheet) {
                                            PhoneNumbersSheet(phoneNumbers: building.cellphoneNumbers)
                                                .presentationDetents([.fraction(0.3), .large])
                                            
                                        }
                                        Spacer()
                                        Button(action: {
                                            showEmailSheet.toggle()
                                        }, label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 175, height: 70)
                                                    .cornerRadius(15)
                                                    .foregroundStyle(.gray)
                                                    .opacity(0.1)
                                                    .shadow(radius: 5)
                                                VStack {
                                                    Image(systemName: "envelope.fill")
                                                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                                                        .foregroundStyle(Color.verdePrincipal)
                                                        .opacity(0.8)
                                                    
                                                    Text("Email")
                                                        .font(.system(size: 12))
                                                        .bold()
                                                        .foregroundStyle(Color.verdePrincipal)
                                                        .padding(.vertical, 3)
                                                        .opacity(0.8)
                                                }
                                            }
                                        })
                                        .sheet(isPresented: $showEmailSheet) {
                                            EmailListView(emails: building.email)
                                                .presentationDetents([.fraction(0.3), .large])
                                        }
                                    }
                                    
                                }
                                
                            }
                            .padding(.leading)
                    }
                }
//                AsyncImage(url: URL(string: building.image)) { image in
//                    image
//                        .resizable()
//                    //                        .resizable()
//                        .scaledToFit()
//                    //                        .frame(width: 370)
//                    //
//                } placeholder: {
//                    
//                    ProgressView()
//                }
//                .cornerRadius(10.0)
//                .frame(width: 393, height: 267)
//                .clipped()
//                .offset(y: -8)
//                Text(building.title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .padding(.leading, 15)
//                
//                Spacer()
                
                VStack {
                    LazyVStack(alignment: .leading, spacing: 20) {
                       
                        Section(header: Text("Descrição")
                            .font(.body)
                            .bold())
                        {
                            Text(building.description)
                                .font(.body)
                          
                        }
                        .padding(.horizontal)
                        
                   
                    }
                    
                    
                }
                .navigationTitle(building.navtitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 78, height: 30)
                                .foregroundStyle(.white)
                                .opacity(0.9)
                                
                        }
                        .offset(x: -76)
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {}, label: {})
                    }
                    ToolbarItem(placement: .principal){
                        Text("")
                    }
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 60, height: 30)
                                .foregroundStyle(.white)
                                .opacity(0.6)
                            
                            Text(building.navtitle)
                                .foregroundStyle(.black)
                                .font(.system(size: 17,weight: .medium , design: .rounded))
                        }
                        .frame(width: 60, height: 30)
                    }
                }
            }
            .ignoresSafeArea()
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
    BuildingDetailView(building: BuildingDetail(title: "Centro de Filosofia e Cências Humanas", description: "O Centro de Filosofia e Ciências Humanas (CFCH), assim denominado a partir de 1974, resultou da fusão de vários departamentos da antiga Faculdade de Filosofia, Ciências e Letras de Pernambuco (FAFIPE), criada em 1950, e do Instituto de Ciências do Homem, inicialmente denominado de Instituto de Filosofia e Ciências Humanas. O Centro é formado por 08 (oito) departamentos – Antropologia e Museologia; Arqueologia; Ciências Geográficas; Sociologia; Ciência Política; Filosofia; História e Psicologia. Edificado em uma área de 25.690 m², além dos departamentos este Centro abriga diversos laboratórios de pesquisa e ensino, como também uma biblioteca setorial.", image: "https://www.ufpe.br/documents/40615/67578/CFCH-camerabaixa.JPG/9398eae5-85d8-4847-9a8b-1e0db9c6fc49?t=1499881089418", navtitle: "CFCH", cellphoneNumbers: ["995215663"], email: [""]))
}
