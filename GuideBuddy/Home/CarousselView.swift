//
//  CarousselView.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI

struct CarousselView: View {
    var caroussel: Category
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: -5){
                ForEach(0..<caroussel.images.count, id: \.self){ index in
                    NavigationLink(destination: caroussel.destination[index],
                                   label: {
                        ZStack{
                            Image(caroussel.images[index])
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(caroussel.titles[index])
                                        .font(.system(size: 17,weight: .semibold , design: .rounded))
                                        .foregroundStyle(caroussel.color[index])
                                        .shadow(radius: 5)
                                }
                                .padding(5)
                               
                            }
                            .padding()
                        }
                        .frame(width: 250, height: 130)
                    })
                }
            }
        })
        
    }
}
#Preview {
    CarousselView(caroussel: Category(images: ["widDocuments", "widUniversities", "widHospital"], titles: ["documento".localized, "faculdade".localized,"hospital".localized], destination: [AnyView(TestView()), AnyView(TestView()), AnyView(TestView())], color: [.white, .white, .white]))
}
