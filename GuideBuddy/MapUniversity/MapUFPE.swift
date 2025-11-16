//
//  MapUFPE.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 12/09/24.
//

import SwiftUI

struct MapUFPE: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var lastScale: CGFloat = 1.0
    @State private var selectedFaculdade: Faculdades = .ufpe
    @State private var selectedBuildings: BuildingUFPE = .blocos

    var body: some View {
        
        
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                  
                    switch selectedFaculdade{
                    case .ufpe:
                        ZStack {
                        
                            ZStack {
                    
                                Image("MapUFPE")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                switch selectedBuildings{
                                    
                                case .blocos:
                                    BuildingView(buildings: [
                                        Building(image: "CFCH", position: CGPoint(x: 96, y: 350), size: CGSize(width: 30, height: 30), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Filosofia e Cências Humanas", description: "Criado a partir da fusão de unidades antigas, o CFCH abriga 8 departamentos nas áreas humanas, além de laboratórios e uma biblioteca setorial. Ocupa uma área de 25.690 m².", image: "https://www.ufpe.br/documents/40615/67578/CFCH-camerabaixa.JPG/9398eae5-85d8-4847-9a8b-1e0db9c6fc49?t=1499881089418", navtitle: "CFCH", cellphoneNumbers: ["(81) 2126-8260"], email: ["diretoria.cfch@ufpe.br", "infraestrutura.cfch@gmail.com"])))),
                                        
                                        Building(image: "CAC", position: CGPoint(x: 93, y: 383), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Artes e Comunicação", description: "O CAC é referência cultural da UFPE, com cursos em artes, design, comunicação e letras. Possui biblioteca, teatro, galeria de arte e núcleos de extensão e pesquisa.", image: "https://www.ufpe.br/documents/40615/2532249/fotcac10.12.19.JPG/ff1018b0-5e74-40d8-b3fc-3766027110c4?t=1576000450352", navtitle: "CAC", cellphoneNumbers: ["(81) 2126.8301", "(81) 2126.8310"], email: ["dircac@ufpe.br", "seapcac@yahoo.com.br", "bib.cac@ufpe.br"])))),
                                        
                                        Building(image: "CTG", position: CGPoint(x: 83, y: 440), size: CGSize(width: 22, height: 22), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Tecnologia e Geocências", description: "Originado da fusão de várias escolas, o CTG possui ampla estrutura com laboratórios, biblioteca e cursos de engenharia, geologia e ciências do mar.", image: "https://www.ufpe.br/documents/39010/0/CTG+-+Principal/527cb48d-0a5c-4bc0-9023-3d324b54981a?t=1480531014050", navtitle: "CTG", cellphoneNumbers: ["(81) 2126-8000"], email: ["extensao.ctg@ufpe.br"])))),
                                        
                                        Building(image: "Area2", position: CGPoint(x: 74, y: 535), size: CGSize(width: 20, height: 10), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Área 2", description: "Espaço de apoio ao CCEN, com aulas dos ciclos básicos de cursos de ciências e engenharias. Atende a milhares de estudantes em disciplinas fundamentais.", image: "https://lh3.googleusercontent.com/p/AF1QipN_1pb6b3YkxgxAxaSCLTj-89IMgiWaS1wSxcfC=w600-k", navtitle: "Área 2", cellphoneNumbers: ["(81) 2126-8000"], email: ["coord-area-2@de.ufpe.br"])))),
                                        
                                        Building(image: "CIN1", position: CGPoint(x: 130, y: 515), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Informática", description: "Referência em ensino e pesquisa em tecnologia no Brasil. Fomenta startups, inovação e possui forte inserção no mercado nacional e internacional.", image: "https://www.ufpe.br/documents/39026/48836/CIN+-+Principal/37042fe8-a1f9-4103-83d8-1327d678b3e5?t=1480530239090", navtitle: "CIN", cellphoneNumbers: ["(81) 2126-8430"], email: ["secgrad@cin.ufpe.br", "secpesq@cin.ufpe.br", "secpos@cin.ufpe.br", "secext@cin.ufpe.br", "secpos-prof@cin.ufpe.br", "secgeral@cin.ufpe.br"])))),
                                        
                                        Building(image: "PETROLEO", position: CGPoint(x: 130, y: 465), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Instituto de Pesquisa em Petróleo e Energia", description: "O LITPEG é um instituto de pesquisa focado em petróleo, gás e energia renovável, promovendo inovação tecnológica e formação de especialistas.", image: "https://www.ufpe.br/documents/1972850/0/Litpeg/072d5b70-889e-44e2-a4ec-c5374ea1c668?t=1557345363173", navtitle: "LITPEG", cellphoneNumbers: ["(81) 3879-5858"], email: ["secretraria.litpeg@ufpe.br"])))),
                                        
                                        Building(image: "PRODUCAO", position: CGPoint(x: 130, y: 440), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Departamento de Engenharia de Produção", description: "Atua na formação e pesquisa em Engenharia de Produção desde 1973. Seu programa de pós-graduação é reconhecido nacionalmente.", image: "https://www.ufpe.br/documents/39479/0/predio_dep.jpg/5ade5102-edf7-499b-9bfc-9fb988809a54?t=1535653162859", navtitle: "DEP", cellphoneNumbers: ["(81) 3879-5566"], email: ["segec.agreste@ufpe.br"])))),
                                        
                                        Building(image: "CIN2", position: CGPoint(x: 170, y: 518), size: CGSize(width: 30, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Informática (Bloco E)", description: "Unidade do CIN dedicada à inovação, pesquisa e empreendedorismo em tecnologia, com infraestrutura moderna e ambiente de criação de startups.", image: "https://embrapii.org.br/wp-content/images/2020/10/DSC08885-1-1024x683.jpg", navtitle: "CIN", cellphoneNumbers: ["(81) 2126-8430"], email: ["secgrad@cin.ufpe.br", "secpesq@cin.ufpe.br", "secpos@cin.ufpe.br", "secext@cin.ufpe.br", "secpos-prof@cin.ufpe.br", "secgeral@cin.ufpe.br"])))),
                                        
                                        Building(image: "CB", position: CGPoint(x: 259, y: 380), size: CGSize(width: 10, height: 10), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Biociências", description: "Centro formado por 10 departamentos nas áreas de biologia, com forte atuação em ensino, pesquisa e formação científica desde 1969.", image: "https://www.ufpe.br/documents/38998/0/CB+-+Principal/124de565-1d9c-42d7-b61d-26d906b37103?t=1480360675339", navtitle: "CB", cellphoneNumbers: ["(81) 2126.8351", "(81) 2126.8358", "(81) 2126.8840"], email: ["centro.biociencias@ufpe.br "])))),
                                        
                                        Building(image: "CCS", position: CGPoint(x: 300, y: 350), size: CGSize(width: 25, height: 25), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Ciências da Saúde", description: "Oferece cursos nas áreas da saúde e mantém forte integração com outras áreas da UFPE, clínicas-escola e redes públicas de saúde.", image: "https://www.ufpe.br/documents/39014/0/CCS+-+Principal/c51f98fa-606c-4704-9d91-35ebfbb4bfe8?t=1480430273557", navtitle: "CCS", cellphoneNumbers: ["(81) 2126-8568"], email: ["diretoria.ccs@ufpe.br", "bibccs@ufpe.br", "extensão.ccs@ufpe.br"])))),
                                        
                                        Building(image: "CCSA", position: CGPoint(x: 162, y: 330), size: CGSize(width: 15, height: 15), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Ciências Sociais e Aplicadas", description: "Reúne cursos e programas de graduação e pós em áreas como administração, economia, turismo, contabilidade e serviço social.", image: "https://www.ufpe.br/documents/39018/0/CCSA+-+Principal/76d266dc-7a86-41fd-b08d-0afb6ac054b5?t=1480530534385", navtitle: "CCSA", cellphoneNumbers: ["(81) 2126-8360", "(81) 2126 8383", "(81) 2126-2126-8917 "], email: ["diretoria.ccsa@ufpe.br", "extensao.ccsa@ufpe.br", "ouvidoriaccsa@ufpe.br"])))),
                                        
                                        Building(image: "OCEANOGRAFIA", position: CGPoint(x: 135, y: 490), size: CGSize(width: 15, height: 15), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Museu de Oceanografia", description: "Possui acervo científico com milhares de exemplares marinhos coletados ao longo de mais de 50 anos de pesquisa oceanográfica.", image: "https://www.ufpe.br/documents/1208775/1208915/WhatsApp+Image+2020-03-27+at+10.24.01+AM+%281%29.jpeg/11055bb5-5f00-4e43-bfa0-c058b6d39190?t=1585346590867", navtitle: "Oceanografia", cellphoneNumbers: ["(81) 2126-8225"], email: ["docean@ufpe.br"]))))
                                    ])

                                case .parada:
                                    BuildingView(buildings: [Building(image: "paradaonibus", position: CGPoint(x: 115, y: 340), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 145, y: 495), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 111, y: 410), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 230, y: 460), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 280, y: 405), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 260, y: 390), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 220, y: 380), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView())), Building(image: "paradaonibus", position: CGPoint(x: 105, y: 460), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView()))])
                                case .nucleos:
                                    BuildingView(buildings: [Building(image: "", position: CGPoint(x: 96, y: 350), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView()))])
                                case .restaurante:
                                    BuildingView(buildings: [Building(image: "restauranteUniversitario", position: CGPoint(x: 130, y: 360), size: CGSize(width: 30, height: 30), destination: AnyView(EmptyView()))])
                                }
                            }
                            .scaleEffect(scale)
                            .offset(x: offset.width, y: offset.height)
                            .gesture(DragGesture()
                                .onChanged { value in
                                    offset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                }
                                .onEnded { _ in
                                    lastOffset = offset
                                }
                            )
                            .gesture(MagnificationGesture()
                                .onChanged { value in
                                    scale = lastScale * value
                                }
                                .onEnded { value in
                                    lastScale = scale
                                }
                            )
                        }
                        .edgesIgnoringSafeArea(.all)
                        
                    case .ufrpe:
                        
                        VStack {
                            Spacer()
                            Text("em_breve_ufrpe".localized)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                        
                    case .ifpe:
                        VStack {
                            Spacer()
                            Text("em_breve_ifpe".localized)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Spacer()
                        }
                        
                    }
//
                }
                .toolbarBackground(.regularMaterial)

                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("faculdades".localized)
//                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text("selecione_filtro".localized)
                            
                            
                            Button(action: {
                                selectedBuildings = .blocos
                            }) {
                                Label("Blocos", systemImage: "building")
                            }
                            Button(action: {
                                selectedBuildings = .nucleos
                            }) {
                                Label("Núcleos", systemImage: "building.columns")
                            }
                           
                            Button(action: {
                                selectedBuildings = .parada
                            }) {
                                Label("Paradas de ônibus", systemImage: "bus.fill")
                            }
                            Button(action: {
                                selectedBuildings = .restaurante
                            }) {
                                Label("Restaurante Universitário", systemImage: "fork.knife")
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundStyle(Color.verdePrincipal)
                        }
                        

                       
                    }
                    ToolbarItem(placement: .principal) {
                        Picker("Selecione a faculdade", selection: $selectedFaculdade) {
                            Text("ufpe".localized).tag(Faculdades.ufpe)
                            Text("ufrpe".localized).tag(Faculdades.ufrpe)
                            Text("ifpe".localized).tag(Faculdades.ifpe)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                                       .scaleEffect(0.9)
                    }
                }
            }
        }
    }
}
#Preview {
    MapUFPE()
}
