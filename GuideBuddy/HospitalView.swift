//
//  HospitalView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/09/24.
//

import SwiftUI

struct HospitalView: View {
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
                        .resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 370)
                    
                } placeholder: {
                 
                    ProgressView()
                }
                Spacer()
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
    func makeACall(to number: String) {
        let tel = "tel://\(number)"
        guard let url = URL(string: tel) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
#Preview {
    HospitalView(building: BuildingDetail(title: "", description: "", image: "", navtitle: "", cellphoneNumbers: ["995215663"]))
}

