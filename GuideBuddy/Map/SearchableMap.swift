//
//  MapTest.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import SwiftUI
import MapKit

struct SearchableMap: View {
    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true

    var body: some View {
        Map(position: $position, selection: $selectedLocation) {
            ForEach(searchResults) { result in
                Marker(coordinate: result.location) {
                    Image(systemName: "mappin")
                }
                .tag(result)
            }
        }
        .ignoresSafeArea()
        .onChange(of: selectedLocation) {
            isSheetPresented = selectedLocation == nil
        }
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedLocation = firstResult
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(searchResults: $searchResults)
        }
    }
}

#Preview {
    SearchableMap()
}
