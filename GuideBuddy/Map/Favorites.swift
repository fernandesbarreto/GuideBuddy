//
//  Favorites.swift
//  GuiBu
//
//  Created by Raquel Ribeiro Hatem de Farias on 12/09/24.
//

import SwiftUI
import SwiftData

struct Favorites: View {
    @Environment(\.modelContext) private var context
    @Query private var location: [SavedLocation]
    
    @State private var itemToDelete: SavedLocation?
    @State private var showDeleteAlert = false
    @State private var deletionIndexSet: IndexSet?

    var body: some View {
        NavigationView {
            List {
                ForEach(location, id: \.id) { item in
                    NavigationLink(destination: SearchableMap(location: item)) {
                        Text(item.name)
                    }
                }
                .onDelete(perform: handleDelete)
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("confirmar"),
                    message: Text("certeza"),
                    primaryButton: .destructive(Text("delete")) {
                        if let indexSet = deletionIndexSet {
                            deleteItems(at: indexSet)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle("favoritos")
        }
    }
    
    private func handleDelete(at offsets: IndexSet) {
       
        deletionIndexSet = offsets
        showDeleteAlert = true
    }
    
    private func deleteItems(at offsets: IndexSet) {
        
        for index in offsets {
            let item = location[index]
            context.delete(item)
        }
    }
}

#Preview {
    Favorites()
}


