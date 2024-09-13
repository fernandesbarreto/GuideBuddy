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
    Slang(slang: "Massa", definition: "É top! Quando algo ou alguém é 10/10, sem defeitos!", examples: "Esse filme foi massa!", imageName: "massa"),
    Slang(slang: "Brocado", definition: "Quando a fome bate tão forte que parece que tem um buraco no estômago.", examples: "Tô brocado, vamos comer?", imageName: "brocado"),
    Slang(slang: "Visse", definition: "Tipo um 'sacou?' só que com um tempero nordestino!", examples: "Amanhã tem prova, visse?", imageName: "visse"),
    Slang(slang: "Retado", definition: "Alguém que é puro poder, coragem ou simplesmente arretado de bom!", examples: "Esse jogador é retado!", imageName: "retado"),
    Slang(slang: "Oxente", definition: "A versão pernambucana de um 'uai' ou 'caramba'!", examples: "Oxente! Como isso aconteceu?", imageName: "oxente"),
    Slang(slang: "Arretado", definition: "Quando algo é tão bom que faz você querer gritar de felicidade!", examples: "Essa banda é arretada!", imageName: "arretado"),
    Slang(slang: "Mangar", definition: "A arte de zoar alguém de leve, só pela diversão.", examples: "Não manga de mim!", imageName: "mangar"),
    Slang(slang: "Cabuloso", definition: "Tão impressionante que você fica sem palavras. Pode ser algo bom ou... nem tanto!", examples: "Esse cara é cabuloso, dança bem demais.", imageName: "cabuloso"),
    Slang(slang: "Catengado", definition: "Quando uma gambiarra não é só uma gambiarra, é uma arte... malfeita.", examples: "Esse conserto ficou catengado.", imageName: "gambiarra"),
    Slang(slang: "Isopor", definition: "O nome mais nordestino e criativo para seu chinelo básico de todo dia.", examples: "Coloca o isopor pra gente ir pra praia.", imageName: "isopor"),
    Slang(slang: "Acochado", definition: "Tá tudo tão apertado que nem o ar passa! Situação complicada, viu?", examples: "Tô acochado com as contas esse mês.", imageName: "acochado"),
    Slang(slang: "Carrapicho", definition: "Aquela pessoa que não larga do seu pé de jeito nenhum. Tipo sombra.", examples: "Ela é um carrapicho, não me deixa em paz.", imageName: "carrapicho"),
    Slang(slang: "Peba", definition: "Quando algo é tão ruim que você se pergunta como alguém teve coragem de fazer isso.", examples: "Esse prato é peba demais.", imageName: "peba"),
    Slang(slang: "Fuleiro", definition: "Aquele que não tem palavra, promete e não cumpre. Cuidado com os fuleiros!", examples: "Ele foi muito fuleiro com ela.", imageName: "fuleiro"),
    Slang(slang: "Migué", definition: "Quando alguém faz aquele drama, enrola ou dá desculpa esfarrapada.", examples: "Ele tá dando migué no trabalho.", imageName: "migue"),
    Slang(slang: "Lapada", definition: "Seja uma pancada ou aquela dose forte de bebida, a lapada vem com força.", examples: "Vamos tomar uma lapada hoje à noite?", imageName: "lapada"),
    Slang(slang: "Bicho solto", definition: "Aquele que não para em casa, tá em todas as festas e ainda com pique!", examples: "Ele é bicho solto, sempre numa festa.", imageName: "bichosolto"),
    Slang(slang: "Rasgar", definition: "Quando você estoura o limite do cartão e ainda faz cara de 'tá tudo bem'.", examples: "Esse mês eu rasguei, comprei um monte de coisa.", imageName: "rasgar"),
    Slang(slang: "Fuleiragem", definition: "Coisa boba, sem importância, que a galera faz só por diversão.", examples: "Isso é só fuleiragem, não leva a sério.", imageName: "fuleiragem"),
    Slang(slang: "Cabra da peste", definition: "A pessoa que não tem medo de nada. Valente e teimoso que só ele!", examples: "Esse cara é cabra da peste, não desiste nunca.", imageName: "cabradapeste")
]
