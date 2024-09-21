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
                                
                                
                                BuildingView(buildings: [
                                    Building(image: "CFCH", position: CGPoint(x: 96, y: 350), size: CGSize(width: 30, height: 30), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Filosofia e Cências Humanas", description: "O Centro de Filosofia e Ciências Humanas (CFCH), assim denominado a partir de 1974, resultou da fusão de vários departamentos da antiga Faculdade de Filosofia, Ciências e Letras de Pernambuco (FAFIPE), criada em 1950, e do Instituto de Ciências do Homem, inicialmente denominado de Instituto de Filosofia e Ciências Humanas. O Centro é formado por 08 (oito) departamentos – Antropologia e Museologia; Arqueologia; Ciências Geográficas; Sociologia; Ciência Política; Filosofia; História e Psicologia. Edificado em uma área de 25.690 m², além dos departamentos este Centro abriga diversos laboratórios de pesquisa e ensino, como também uma biblioteca setorial.Estrutura", image: "https://www.ufpe.br/documents/40615/67578/CFCH-camerabaixa.JPG/9398eae5-85d8-4847-9a8b-1e0db9c6fc49?t=1499881089418", navtitle: "CFCH", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CAC", position: CGPoint(x: 93, y: 383), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Artes e Comunicação", description: "A criação do Centro de Artes e Comunicação ocorreu em 1975, pela junção da Escola das Belas Artes, da Faculdade de Arquitetura, do Departamento de Letras e do Curso de Biblioteconomia.                                                                                                                       Considerado o centro de efervescência cultural da universidade, o CAC realiza atividades, apresentações, eventos e exposições periódicas de artes plásticas, desenho, projetos arquitetônicos, música, dança, literatura, design, fotografia, produção audio-visual, produção de mídia, mídia digital, teatro, performance, além de ciência da informação e pesquisa.                                                                                                                                 A biblioteca Joaquim Cardozo, no CAC, possui um acervo que está totalmente direcionado para atender os cursos de graduação e pós-graduação ofertados no Centro. Se encontra também na biblioteca a sala do acervo da coleção histórica da Oficina Guaianases de Gravuras. Na Galeria Capibaribe, o CAC recebe artistas locais, regionais e coletivas de estudantes para vários tipos de exposição, performance e experimentação. Os temas sociais também fazem parte das discussões no Centro por meio da Comissão de Direitos Humanos Dom Hélder Câmara (CDH) que, na sua composição, conta com professores de diversos departamentos e estudantes da graduação. Também abriga o Núcleo de Línguas e Culturas (NLC), um projeto de extensão voltado para o ensino de línguas estrangeiras e suas respectivas culturas, com o objetivo de proporcionar experiência profissional pedagógico-cultural aos alunos de graduação e pós-graduação e fomentar o intercâmbio entre alunos/professores dos países cujas línguas e culturas estão sendo estudadas ou serão ensinadas.                                                                                                                                         A Diretoria do CAC é composta por equipes setoriais de atendimento as necessidades e demandas de apoio acadêmico, administrativos, de serviços outros como a: secretaria da Direção; de apoio acadêmico o Núcleo de Estudos e Assessoria Pedagógica (NEAP); de infraestrutura e administração a Coordenação de Infraestrutura, Finanças e Compras (CIFIC); para acesso a laboratório de informática e serviços técnicos de manutenção o Laboratório de Informática e Ensino da Graduação (LIEG); para impulsionar, divulgar e avaliar ações extensionistas acadêmicas a Coordenação Setorial de Extensão (CSE); e para difundir através de mídia impressa e digital as atividades e eventos do Centro e de interesse deste a Coordenação de Comunicação e Design (CCD). O CAC ocupa uma área de 15.500 metros quadrados, distribuídos entre salas de aula, departamentos, setores, biblioteca, teatro, núcleos de pesquisas, laboratórios, hemeroteca, oficinas, estúdios, auditórios, anfiteatro, galeria de arte e jardins.                                                                                                       Integram o CAC oito Departamentos Acadêmicos. Conheça mais sobre cada um destes setores através destes links: Arquitetura e Urbanismo, Ciência da Informação, Comunicação Social, Design, Expressão Gráfica, Letras, Música e Artes.", image: "https://www.ufpe.br/documents/40615/2532249/fotcac10.12.19.JPG/ff1018b0-5e74-40d8-b3fc-3766027110c4?t=1576000450352", navtitle: "CAC", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CTG", position: CGPoint(x: 83, y: 440), size: CGSize(width: 22, height: 22), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Tecnologia e Geocências", description: "O Centro de Tecnologia e Geociências - Escola de Engenharia de Pernambuco (CTG-EEP) resultou da fusão da antiga Escola de Engenharia de Pernambuco, fundada em 1895, com a Escola de Química, a Escola de Geologia, o Laboratório de Ciências do Mar e o Centro de Energia Nuclear. Suas instalações, no Campus, ocupam uma área construída de 50.163m2, abrigando laboratórios de ensino e pesquisa e uma biblioteca setorial.", image: "https://www.ufpe.br/documents/39010/0/CTG+-+Principal/527cb48d-0a5c-4bc0-9023-3d324b54981a?t=1480531014050", navtitle: "CTG", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "Area2", position: CGPoint(x: 74, y: 535), size: CGSize(width: 20, height: 10), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Área 2", description: "A Área II é um órgão de apoio do Centro de Ciências Exatas e da Natureza(CCEN).Ela  foi criada em 1971 com o objetivo de congregar os Ciclos Geral e Básico dos cursos de Tecnologia e de Ciências Exatas, atendendo atualmente 8.991 alunos distribuidos em 179 turmas.                                                                                                                                       O ciclo básico está sob a responsabilidade do CCEN, o qual é reconhecido pelo potencial de suas pesquisas e pela qualificação de seus docentes.O centro fornece base científica necessária para o desenvolvimento da carreira escolhida e para a formação educativa e profissional com qualidade ao conjunto de estudantes que cursam as disciplinas básicas dos cursos de graduação do CCEN,CIN e do Centro de Tecnologia e Geociências.                                                                                                                                         A Área II atende aos seguintes cursos:                                                                                                                                       Bacharelado: ABI - Engenharia, Engenharia(Alimentos, Biomédica, Cartográfica, Civil, Computação, Controle e Automação, Eletrônica, Elétrica, Energia, Mecânica, Minas, Materiais, Naval, Produção, Química e Telecomunicações), Ciência da Computação, Estatística, Física,  Matemática, Oceanografia, Química e Geologia.                                                                                                                                          Licenciatura: Física, Matemática e Química.", image: "https://lh3.googleusercontent.com/p/AF1QipN_1pb6b3YkxgxAxaSCLTj-89IMgiWaS1wSxcfC=w600-k", navtitle: "Área 2", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CIN1", position: CGPoint(x: 130, y: 515), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Informática", description: "O Centro de Informática da UFPE é um dos mais renomados centros de ensino e pesquisa em computação do Brasil e da América Latina, formador de profissionais qualificados e de excelência em Tecnologia da Informação e Comunicação (TIC). É uma instituição fundamental para o crescente mercado de tecnologia, que estimula a criatividade de seus alunos e busca constantemente soluções inovadoras para o cotidiano de pessoas e empresas.                                                                                                                                          Por incentivar o empreendedorismo, o CIn é o lugar de origem de diversas empresas de sucesso, que começaram como startups no Centro. A partir de parcerias com o setor privado, o CIn-UFPE também se destaca como importante parceiro para empresas que buscam inovar em seus produtos e serviços. A sólida formação oferecida em seus cursos de graduação e pós-graduação permite que seus egressos se destaquem no mercado de trabalho nacional e internacional. O CIn-UFPE caracteriza-se pelo pioneirismo e pela inovação e a essência que deu origem ao Centro permanece até hoje: ousadia, criatividade e orientação ao futuro.", image: "https://www.ufpe.br/documents/39026/48836/CIN+-+Principal/37042fe8-a1f9-4103-83d8-1327d678b3e5?t=1480530239090", navtitle: "CIN", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "PETROLEO", position: CGPoint(x: 130, y: 465), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Instituto de Pesquisa em Petróleo e Energia", description: "O LITPEG é um instituto de pesquisa da UFPE que objetiva integrar indústria e academia visando o desenvolvimento de novas tecnologias, fomento à inovação, e formação de recursos humanos para diversas áreas da cadeia produtiva da indústria do petróleo, gás natural, biocombustíveis e energia renovável. O instituto foi inaugurado em março de 2019, e já nasceu como um importante instrumento de geração de inovação e produção de conhecimento no NE do Brasil. O Instituto LITPEG está vinculado administrativamente à Reitoria da UFPE, e sua pró reitoria de pesquisa PROPESQ-UFPE. Conforme estabelecido no novo estatuto da universidade, o instituto possui uma maior flexibilidade administrativa e possivelmente maior capacidade de captação de recursos externos, do setor público e privado, para o financiamento de pesquisa aplicada.", image: "https://www.ufpe.br/documents/1972850/0/Litpeg/072d5b70-889e-44e2-a4ec-c5374ea1c668?t=1557345363173", navtitle: "LITPEG", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "PRODUCAO", position: CGPoint(x: 130, y: 440), size: CGSize(width: 20, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Departamento de Engenharia de Produção", description: "A atuação da UFPE na área de Engenharia de Produção teve início em 1973, através de Pós-Graduação Lato Sensu, tendo atuado como Stricto Sensu (mestrado) por quatro anos até 1985. No segundo semestre de 1996 a UFPE estabeleceu um Plano Diretor para a área de Engenharia de Produção, que foi implantado desde então. Este plano propiciou uma ação de integração de pesquisadores que atuam na área, através da elaboração do projeto para criação, em 1997, do PPGEP (Programa de Pós-Graduação em Engenharia de Produção). Iniciado em março de 1998 o PPGEP foi credenciado pela CAPES em agosto do mesmo ano e atualmente está avaliado com conceito 7 pela CAPES.", image: "https://www.ufpe.br/documents/39479/0/predio_dep.jpg/5ade5102-edf7-499b-9bfc-9fb988809a54?t=1535653162859", navtitle: "DEP", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CIN2", position: CGPoint(x: 170, y: 518), size: CGSize(width: 30, height: 20), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Informática (Bloco E)", description: "O Centro de Informática da UFPE é um dos mais renomados centros de ensino e pesquisa em computação do Brasil e da América Latina, formador de profissionais qualificados e de excelência em Tecnologia da Informação e Comunicação (TIC). É uma instituição fundamental para o crescente mercado de tecnologia, que estimula a criatividade de seus alunos e busca constantemente soluções inovadoras para o cotidiano de pessoas e empresas.                                                                                                                                          Por incentivar o empreendedorismo, o CIn é o lugar de origem de diversas empresas de sucesso, que começaram como startups no Centro. A partir de parcerias com o setor privado, o CIn-UFPE também se destaca como importante parceiro para empresas que buscam inovar em seus produtos e serviços. A sólida formação oferecida em seus cursos de graduação e pós-graduação permite que seus egressos se destaquem no mercado de trabalho nacional e internacional. O CIn-UFPE caracteriza-se pelo pioneirismo e pela inovação e a essência que deu origem ao Centro permanece até hoje: ousadia, criatividade e orientação ao futuro.", image: "https://embrapii.org.br/wp-content/images/2020/10/DSC08885-1-1024x683.jpg", navtitle: "CIN(Bloco E)", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CB", position: CGPoint(x: 259, y: 380), size: CGSize(width: 10, height: 10), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Biociências", description: "O Centro de Ciências Biológicas teve início como Instituto de Biociências para o qual, a princípio, foi criada uma comissão provisória de estruturação, composta pelos professores: Dr. Marcionilo de Barros Lins – Presidente (Setor de Bioquímica); Dr. Hélio Bezerra Coutinho (Setor de Histoquímica); Dr. Moacyr Carneiro Leão (Setor de Biofísica); Dr. Dárdano de Andrade Lima (Setor de Botânica, Ecologia e Zoologia); Dr. Geraldo Mariz, como coordenador de História Natural da antiga Faculdade de Filosofia; Dr. Mota Barbosa, representante do Setor de Biologia da área de Geociências; e Dr. Aluízio Bezerra Coutinho.    Foram criados então sete Departamentos: Biologia Geral, Genética e Patologia Geral e Experimental (Chefe: Professor Aluízio Bezerra Coutinho); Bioquímica (Chefe: Professor Marcionilo de Barros Lins); Biofísica (Chefe: Professor Moacir Carneiro Leão); Histoquímica e Histofisiologia Geral e Morfogênese (Chefe: Professor Hélio Bezerra Coutinho); Botânica (Chefe: Professor Geraldo Mariz); Zoologia (Chefe: Professor Geraldo Almeida); e Ecologia (Chefe: Professor Dárdano de Andrade Lima).    Uma vez estruturado o Instituto de Biociências teve como primeiro diretor, em 1969, o Dr. Marcionilo de Barros Lins. Em 1972, por decreto, foram criados Centros Acadêmicos, passando o Instituto a ser denominado e estruturado como Centro de Ciências Biológicas (CCB) na UFPE.    Atualmente, o CCB está composto por 10 Departamentos: Anatomia, Antibióticos, Botânica, Biofísica e Radiobiologia, Bioquímica, Fisiologia e Farmacologia, Genética, Histologia e Embriologia, Micologia e Zoologia.", image: "https://www.ufpe.br/documents/38998/0/CB+-+Principal/124de565-1d9c-42d7-b61d-26d906b37103?t=1480360675339", navtitle: "CB", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CCS", position: CGPoint(x: 300, y: 350), size: CGSize(width: 25, height: 25), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Ciências da Saúde", description: "O Centro de Ciências da Saúde (CCS) da Universidade Federal de Pernambuco (UFPE) foi criado em 1975 com a fusão de várias escolas superiores do Recife.  Atualmente possui 09 (nove) cursos de graduação: Farmácia, Odontologia,  Enfermagem, Nutrição, Fisioterapia, Terapia Ocupacional, Fonoaudiologia e Educação Física (Licenciatura e Bacharelado).                                                                                                                                        Mantém projetos e ações articuladas especialmente com o CB, CFCH, CCSA e CCM que também formam profissionais da saúde e ainda com os demais centros acadêmicos visto que saúde transcende o cuidado assistencial. Os projetos integrados de ensino, pesquisa, gestão e inovação têm sido valorizados e potencializados   Conta, na pós-graduação, com 8 programas: Nutrição, Ciências Farmacêuticas, Saúde da Comunicação Humana, Fisioterapia, Gerontologia, Ed. Física, Odontologia e Enfermagem.                                                                                                                                     O atual modelo de gestão tem fortalecido as instâncias colegiadas de gestão com a implantação das câmaras setoriais (graduação, pós-graduação, extensão, ensino-serviço rede escola UFPE,  pesquisa e inovação).                                                                                                                                       Os profissionais formados atuam nos sistemas público e privado da saúde, bem como nas áreas sociais e de educação. Há ainda inserção nas áreas industriais e no setor de inovação. A rede de clínicas-escola própria somada às atividades práticas que ocorrem, sobretudo, nas redes públicas estaduais e municipais de saúde e no hospital das clinicas, conformam um campo vasto de cenários de práticas e aprendizagem de habilidades e de produção de conhecimento.                                                                                                                                       A defesa do direito à Saúde, à Educação e à Seguridade Social, à Democracia e à Autonomia universitária, com valorização do conhecimento científico e humanístico para a transformação social, tem marcado o modo de operar da comunidade que faz o Centro.", image: "https://www.ufpe.br/documents/39014/0/CCS+-+Principal/c51f98fa-606c-4704-9d91-35ebfbb4bfe8?t=1480430273557", navtitle: "CCS", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "CCSA", position: CGPoint(x: 162, y: 330), size: CGSize(width: 15, height: 15), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Centro de Ciências Sociais e Aplicadas", description: "O Centro de Ciências Sociais Aplicadas (CCSA) foi fundado em 1974 com a junção da Faculdade de Ciências Econômicas e da Escola de Serviço Social e, atualmente, é formado por: cinco Departamentos Acadêmicos (Ciências Administrativas, Ciências Contábeis e Atuariais, Economia, Hotelaria e Turismo e Serviço Social); oito Cursos de Graduação (Administração, Ciências Atuariais, Ciências Contábeis - modalidades presencial e EaD -, Ciências Econômicas, Hotelaria, Secretariado, Serviço Social  e Turismo); e sete Programas de Pós-Graduação (Administração, Ciências Contábeis, Economia, Gestão e Economia da Saúde, Gestão Pública para o Desenvolvimento do Nordeste, Hotelaria e Turismo, Serviço Social).", image: "https://www.ufpe.br/documents/39018/0/CCSA+-+Principal/76d266dc-7a86-41fd-b08d-0afb6ac054b5?t=1480530534385", navtitle: "CCSA", cellphoneNumbers: ["+55 81 98300-4947"])))),
                                    Building(image: "OCEANOGRAFIA", position: CGPoint(x: 135, y: 490), size: CGSize(width: 15, height: 15), destination: AnyView(BuildingDetailView(building: BuildingDetail(title: "Museu de Oceanografia", description: "Ao longo de mais de 50 anos de trabalho, o Departamento  de Oceanografia reuniu importante acervo científico que documenta não só toda a história do conhecimento oceanográfico a partir do início de seu funcionamento, como também a biodiversidade da plataforma continental e do domínio marítimo adjacente ao Brasil, com ênfase às regiões Norte e Nordeste, porém com abrangência geográfica que se estende até o norte da Argentina. Nesta área de abrangência geográfica, ressaltam-se as comissões oceanográficas nacionais e internacionais, tendo como principal área de prospecção a plataforma continental brasileira. O material resultante destas expedições, bem como o proveniente de inúmeras coletas costeiras e estuarinas, concomitantemente com os espécimes obtidos através de intercâmbios com outras coleções científicas nacionais (FURG, USP, MNRJ, UFRJ, UERJ, UESC, dentre outras) e estrangeiras (laboratórios de Paris, Washington, Frankfurt, etc) compõe um acervo conjunto de 15.000 lotes de crustáceos, 7.000 de moluscos, 4.000 de outros invertebrados (particularmente poliquetas e esponjas), 8.000 de plâncton (fitoplâncton e zooplâncton) e 1.300 de peixes. ", image: "https://www.ufpe.br/documents/1208775/1208915/WhatsApp+Image+2020-03-27+at+10.24.01+AM+%281%29.jpeg/11055bb5-5f00-4e43-bfa0-c058b6d39190?t=1585346590867", navtitle: "Oceanografia", cellphoneNumbers: ["+55 81 98300-4947"]))))
                                ])
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
                        Text("mapaUFRPE")
                    }
//
                }
                .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)

                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle("Faculdades")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text("Selecione o filtro")
                            
                            
                            Button(action: {
                             
                            }) {
                                Label("Blocos", systemImage: "building")
                            }
                            Button(action: {
                             
                            }) {
                                Label("Núcleos", systemImage: "building.columns")
                            }
                           
                            Button(action: {
                              
                            }) {
                                Label("Paradas de ônibus", systemImage: "bus.fill")
                            }
                            Button(action: {
                              
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
                            Text(" UFPE").tag(Faculdades.ufpe)
                            Text("UFRPE").tag(Faculdades.ufrpe)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
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
