//
//  Slang.swift
//  GuiBu
//
//  Created by Pedro Fernandes Barreto Costa on 12/09/24.
//

import Foundation

struct Slang: Identifiable {
    let id = UUID()
    let slang: String
    let definition: String
    let examples: String
    let imageName: String
}

let slangs: [Slang] = [
    Slang(slang: "Massa", definition: "Algo muito bom, legal", examples: "Esse filme foi massa!", imageName: "massa"),
    Slang(slang: "Brocado", definition: "Estar com muita fome", examples: "Tô brocado, vamos comer?", imageName: "bichosolto"),
    Slang(slang: "Visse", definition: "Utilizado para confirmar algo, similar a 'entendeu?'", examples: "Amanhã tem prova, visse?", imageName: "visse"),
    Slang(slang: "Retado", definition: "Pessoa corajosa ou algo muito bom", examples: "Esse jogador é retado!", imageName: "bichosolto"),
    Slang(slang: "Oxente", definition: "Expressão de surpresa ou espanto", examples: "Oxente! Como isso aconteceu?", imageName: "bichosolto"),
    Slang(slang: "Arretado", definition: "Algo incrível, excepcional", examples: "Essa banda é arretada!", imageName: "bichosolto"),
    Slang(slang: "Mangar", definition: "Zombar ou debochar de alguém", examples: "Não manga de mim!", imageName: "bichosolto"),
    Slang(slang: "Cabuloso", definition: "Algo impressionante ou assustador", examples: "Esse cara é cabuloso, dança bem demais.", imageName: "cabuloso"),
    Slang(slang: "Catengado", definition: "Algo malfeito ou improvisado", examples: "Esse conserto ficou catengado.", imageName: "bichosolto"),
    Slang(slang: "Isopor", definition: "Gíria para chinelo", examples: "Coloca o isopor pra gente ir pra praia.", imageName: "bichosolto"),
    Slang(slang: "Acochado", definition: "Estar apertado ou em uma situação difícil", examples: "Tô acochado com as contas esse mês.", imageName: "bichosolto"),
    Slang(slang: "Carrapicho", definition: "Pessoa que não desgruda, que segue aonde você vai", examples: "Ele é um carrapicho, não me deixa em paz.", imageName: "bichosolto"),
    Slang(slang: "Peba", definition: "Algo de baixa qualidade", examples: "Essa roupa é peba demais.", imageName: "massa"),
    Slang(slang: "Fuleiro", definition: "Pessoa desleal ou desonesta", examples: "Ele foi muito fuleiro com ela.", imageName: "bichosolto"),
    Slang(slang: "Migué", definition: "Fazer corpo mole, enrolar", examples: "Ele tá dando migué no trabalho.", imageName: "bichosolto"),
    Slang(slang: "Lapada", definition: "Golpe ou bebida alcoólica", examples: "Vamos tomar uma lapada hoje à noite?", imageName: "bichosolto"),
    Slang(slang: "Bicho solto", definition: "Pessoa extrovertida, que gosta de festa", examples: "Ele é bicho solto, sempre numa festa.", imageName: "bichosolto"),
    Slang(slang: "Rasgar", definition: "Gastar muito dinheiro", examples: "Esse mês eu rasguei, comprei um monte de coisa.", imageName: "bichosolto"),
    Slang(slang: "Fuleiragem", definition: "Besteira ou brincadeira sem importância", examples: "Isso é só fuleiragem, não leva a sério.", imageName: "bichosolto"),
    Slang(slang: "Cabra da peste", definition: "Pessoa corajosa, determinada", examples: "Esse cara é cabra da peste, não desiste nunca.", imageName: "bichosolto")
]

