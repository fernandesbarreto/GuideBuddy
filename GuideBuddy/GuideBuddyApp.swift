//
//  GuideBuddyApp.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 26/08/24.
//

import SwiftUI
import SwiftData

@main
struct GuideBuddyApp: App {
    @StateObject private var languageManager = LanguageManager()
    
    // Configura o modelContainer com tratamento de erros
    var container: ModelContainer {
        let schema = Schema([Prompt.self, User.self, ItemEntity.self, SavedLocation.self])
        
        do {
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // Se houver erro de migração, deleta o banco antigo e cria um novo
            print("❌ Erro ao criar ModelContainer: \(error)")
            print("   Tentando deletar banco antigo e criar novo...")
            
            // Deleta o banco antigo (caminho padrão do SwiftData)
            let fileManager = FileManager.default
            if let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                let storeURL = appSupportURL.appendingPathComponent("default.store")
                try? fileManager.removeItem(at: storeURL)
                print("   Banco antigo deletado")
            }
            
            // Tenta criar novamente
            do {
                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Não foi possível criar ModelContainer: \(error)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            StartView()
            //Login()
              .environmentObject(languageManager)
        }
        .modelContainer(container)
    }
}
