//
//  TermosView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


import SwiftUI

struct TermosView: View {
    private let termosDeUso = """
    1. PARTES
    Estes Termos de Uso (“Termos”) regem o acesso e uso do aplicativo GuiBU (“App”), disponibilizado por Pedro Henrique Nunes da Silveira Bezerra, CPF 076.052.684-24, residente em Rua Nova da Mangueira, 782, Brasil, e-mail de contato plantei.app@gmail.com.

    2. ACEITAÇÃO DOS TERMOS
    2.1. Ao acessar, instalar ou usar o App, você (“Usuário”) declara que leu, entendeu e concorda integralmente com estes Termos e com a Política de Privacidade do GuiBU, disponível em:
    https://docs.google.com/document/d/1KSmS_J9uAhe6YZ4p1KxcdIGofeH32wQ-_xP2QLrzq60/edit?usp=sharing
    2.2. Caso não concorde com qualquer disposição destes Termos, não instale nem utilize o App.

    3. OBJETO
    3.1. Este documento estabelece as condições sob as quais o Usuário poderá utilizar o App, que permite:
    - Criar conta;
    - Personalizar cômodos e plantas em realidade aumentada;
    - Receber feedbacks de saúde vegetal;
    - E acessar demais funcionalidades oferecidas.

    4. CADASTRO E CONTA
    4.1. Para utilizar o App, o Usuário deverá criar conta mediante login obrigatório via Google ou Apple ID, por meio do qual obtemos seu endereço de e-mail.
    4.2. É de responsabilidade do Usuário manter em sigilo suas credenciais de acesso. A Empresa não se responsabiliza por uso indevido de sua conta.

    5. ACESSO A FUNÇÕES DO DISPOSITIVO
    5.1. O App requer, sempre mediante consentimento explícito, acesso à câmera, à galeria de fotos e ao Face ID do dispositivo, exclusivamente para permitir a personalização virtual de cômodos e plantas em realidade aumentada.

    6. LICENÇA DE USO
    6.1. Concedemos ao Usuário uma licença não exclusiva, intransferível e revogável para uso pessoal e não comercial do App, de acordo com estes Termos.
    6.2. É vedado ao Usuário:
    - Reproduzir, distribuir, alterar ou criar obras derivadas do App;
    - Descompilar, fazer engenharia reversa ou tentar extrair código-fonte;
    - Violar direitos de propriedade intelectual de Pedro Henrique N. S. Bezerra.

    7. PROPRIEDADE INTELECTUAL
    7.1. Todos os direitos autorais e demais direitos de propriedade intelectual do App (software, design, textos, imagens e marcas) pertencem a Pedro Henrique N. S. Bezerra ou a terceiros licenciantes.

    8. POLÍTICA DE PRIVACIDADE
    8.1. O tratamento de dados pessoais do Usuário está regulado pela Política de Privacidade do GuiBU, que faz parte integrante destes Termos.
    8.2. Para informações completas sobre coleta, uso, compartilhamento, armazenamento, retenção e direitos sob a Lei Geral de Proteção de Dados (LGPD), consulte:
    https://docs.google.com/document/d/1KSmS_J9uAhe6YZ4p1KxcdIGofeH32wQ-_xP2QLrzq60/edit?usp=sharing

    9. ISENÇÃO DE GARANTIAS
    9.1. O App é fornecido “no estado em que se encontra”, sem garantias de qualquer natureza, expressas ou implícitas. Não garantimos que o App estará livre de erros, interrupções ou vulnerabilidades.

    10. LIMITAÇÃO DE RESPONSABILIDADE
    10.1. Em nenhuma hipótese seremos responsáveis por danos indiretos, incidentais, especiais ou consequenciais decorrentes do uso ou incapacidade de uso do App.
    10.2. Nossa responsabilidade total por quaisquer danos diretos está limitada ao valor efetivamente pago pelo Usuário, se houver.

    11. ATUALIZAÇÕES E MODIFICAÇÕES
    11.1. Reservamo-nos o direito de, a qualquer tempo, alterar funcionalidades, design, preços ou mesmo estes Termos.
    11.2. As alterações vigorarão a partir da publicação de nova versão destes Termos no próprio App. É responsabilidade do Usuário consultá-los periodicamente.

    12. RESCISÃO
    12.1. Estes Termos poderão ser rescindidos por nós, sem aviso prévio, caso o Usuário viole quaisquer disposições aqui previstas.
    12.2. Em caso de rescisão, cessará seu direito de uso do App. Para exclusão de conta, acesse os Ajustes do aplicativo; seus dados serão removidos conforme previsto na Política de Privacidade.

    13. LEI APLICÁVEL E FORO
    13.1. Estes Termos são regidos pelas leis brasileiras, em especial pelo Código Civil, pelo Marco Civil da Internet e pela Lei Geral de Proteção de Dados (Lei nº 13.709/2018).
    13.2. Fica eleito o foro da comarca de ________________, com renúncia a qualquer outro, por mais privilegiado que seja, para dirimir quaisquer controvérsias.

    14. CONTATO
    14.1. Dúvidas, solicitações ou reclamações sobre estes Termos devem ser enviadas para plantei.app@gmail.com.
    """
    
    var body: some View {
        ScrollView {
            Text(termosDeUso)
                .font(.system(size: 16))
                .padding()
                .multilineTextAlignment(.leading)
        }
        .navigationTitle("termos_de_uso".localized)
        
    }
}

#Preview {
    NavigationStack {
        TermosView()
    }
}
