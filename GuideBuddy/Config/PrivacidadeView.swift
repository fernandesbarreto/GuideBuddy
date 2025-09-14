//
//  PrivacidadeView.swift
//  GuiBu
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 14/09/25.
//


//
//  PrivacidadeView.swift
//  GuiBU
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 11/04/25.
//

import SwiftUI

struct PrivacidadeView: View {
    var body: some View {
        ScrollView {
            Text("""
            Esta Política de Privacidade descreve como a equipe de desenvolvimento do aplicativo GuiBU, representada por Pedro Henrique Nunes da Silveira Bezerra (CPF 076.052.684-24) e demais colaboradores, com sede em Rua Nova da Mangueira, 782, Brasil, e-mail de contato guibu.app@gmail.com, coleta, utiliza, compartilha e protege os dados dos usuários do GuiBU.
            Esta versão foi atualizada em 25 de abril de 2025.

            Ao instalar e utilizar o GuiBU, você concorda com as práticas aqui descritas. Para que você possa criar sua conta e manter suas personalizações de cômodos e plantas, solicitamos o seu endereço de e-mail e oferecemos a opção de login via Google ou Apple ID. Além disso, o aplicativo requer acesso à câmera e à galeria do seu dispositivo, bem como autorização para uso do Face ID, exclusivamente para que nossa ferramenta de inteligência artificial:

            1 - Analise imagens das suas plantas.
            2 - Avalie seu estado de saúde.
            3 - Forneça feedbacks personalizados.

            Todas essas solicitações ocorrem mediante seu consentimento explícito no momento do cadastro e do uso dessas funcionalidades.
            Os dados coletados são tratados em conformidade com a Lei Geral de Proteção de Dados (LGPD), com base em:

            1 - Execução de contrato para viabilizar as funcionalidades contratadas.
            2 - Consentimento para uso da câmera, galeria e Face ID.
            3 - Legítimo interesse para aprimoramento do aplicativo por meio de análises de uso e publicidade segmentada.

            Para esses fins, podemos compartilhar informações anônimas e agregadas com o Google Analytics, bem como dados para campanhas de marketing veiculadas via Instagram Ads e Facebook Ads. Exceto por esses parceiros e pelos provedores de serviços de nuvem responsáveis pelo armazenamento, não compartilhamos seus dados pessoais com outras empresas.

            Todos os dados são armazenados em servidores em nuvem, protegidos por criptografia em trânsito (TLS) e em repouso (AES-256), além de controles de acesso baseados em função (RBAC), garantindo a confidencialidade e integridade das suas informações. Mantemos seus dados enquanto sua conta estiver ativa, sem prazo predeterminado de retenção; no entanto, você pode solicitar a qualquer momento a exclusão ou correção de seus dados. Para isso, envie uma mensagem para guibu.app@gmail.com com o assunto “Exclusão de Dados”. Seu pedido será processado em até 15 dias úteis.

            Em atenção aos seus direitos previstos na LGPD, você pode:

            1 - Confirmar a existência de tratamento
            2 - Acessar seus dados
            3 - Corrigir informações inexatas
            4 - Solicitar anonimização, bloqueio ou eliminação
            5 - Revogar o consentimento fornecido

            Caso tenha dúvidas, reclamações ou deseje exercer seus direitos, entre em contato pelo e-mail guibu.app@gmail.com.
            Reservamo-nos o direito de atualizar esta Política de Privacidade a qualquer momento; a versão mais recente estará sempre disponível neste documento, com a data de “Última atualização” devidamente revisada.
            """)
            .font(.system(size: 16))
            .padding()
        }
        .navigationTitle("Políticas de privacidade")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        PrivacidadeView()
    }
}
