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
                        HStack {
                            Text(item.name)
                            Spacer()
                            Button(action: {
                                itemToDelete = item
                                deletionIndexSet = IndexSet(integer: location.firstIndex(of: item)!)
                                showDeleteAlert = true
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .onDelete { indexSet in
                    deletionIndexSet = indexSet
                    if let index = indexSet.first {
                        itemToDelete = location[index]
                        showDeleteAlert = true
                    }
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("confirmar"),
                    message: Text("certeza"),
                    primaryButton: .destructive(Text("deletar")) {
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
