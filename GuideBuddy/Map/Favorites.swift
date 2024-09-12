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
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let indexSet = deletionIndexSet {
                            deleteItems(at: indexSet)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle("Favorites")
        }
    }
    
    private func handleDelete(at offsets: IndexSet) {
        // Capture the index set for confirmation
        deletionIndexSet = offsets
        showDeleteAlert = true
    }
    
    private func deleteItems(at offsets: IndexSet) {
        // Delete the items at the given offsets
        for index in offsets {
            let item = location[index]
            context.delete(item)
        }
    }
}

#Preview {
    Favorites()
}


