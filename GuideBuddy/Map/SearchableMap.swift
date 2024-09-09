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
    
    @State private var locationService = LocationService(completer: .init())
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    
    @State private var isSheetViewPresented: Bool = true
    @State private var isSheetPlaceViewPresented: Bool = false
    @State private var placeImages: [URL?] = []
    var body: some View {
        mapView
            .ignoresSafeArea()
            .onChange(of: selectedLocation) { newValue in
                print("selectedLocation \(selectedLocation) and new value \(newValue)")
                if let location = newValue {
                    Task {
                        placeImages = await locationService.fetchImages(for: [location])
                        isSheetViewPresented = false
                        isSheetPlaceViewPresented = true
                    }
                }
            }
            .onChange(of: searchResults) { newValue in
                if !newValue.isEmpty {
                    isSheetViewPresented = true
                }
            }
            .sheet(isPresented: $isSheetViewPresented) {
                SheetView(searchResults: $searchResults)
            }
            .sheet(isPresented: $isSheetPlaceViewPresented) {
                if let location = selectedLocation {
                    SheetPlaceView(location: location, images: placeImages)
                }
            }
    }

    private var mapView: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            ForEach(searchResults) { result in
                Marker(coordinate: result.location) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                .tag(result)
            }
        }
    }
}

#Preview {
    SearchableMap()
}

