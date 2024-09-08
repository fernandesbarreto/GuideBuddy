//
//  MapTest.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import SwiftUI
import MapKit

struct SearchableMap: View {
    @State private var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813),
            span: MKCoordinateSpan(latitudeDelta: 0.36, longitudeDelta: 0.36)
        )
    )
    
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true
    
    var body: some View {
        mapView
            .ignoresSafeArea()
            .onChange(of: selectedLocation) { newValue in
                isSheetPresented = true
            }
            .onChange(of: searchResults) { newValue in
                if let firstResult = newValue.first, newValue.count == 1 {
                    selectedLocation = firstResult
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                SheetView(searchResults: $searchResults)
            }
    }

    private var mapView: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            ForEach(searchResults) { result in
                Marker(coordinate: result.location) {
                    Image(systemName: "mappin")
                }
                .tag(result)
            }
        }
    }
}

#Preview {
    SearchableMap()
}

