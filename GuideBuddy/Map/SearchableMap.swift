//
//  MapTest.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

//import SwiftUI
//import MapKit
//
//struct SearchableMap: View {
//    @State private var cameraPosition = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813),
//            span: MKCoordinateSpan(latitudeDelta: 0.36, longitudeDelta: 0.36)
//        )
//    )
//    
//    @State private var locationService = LocationService(completer: .init())
//    @State private var searchResults = [SearchResult]()
//    @State private var selectedLocation: SearchResult?
//    @State private var placeImages: [URL?] = []
//    
//    @State private var isSheetPresented: Bool = true
//    
//    
//    var location: SavedLocation?
//
//    var body: some View {
//        mapView
//            .ignoresSafeArea()
//            .onChange(of: selectedLocation) { newValue in
//                if let location = newValue {
//                    Task {
//                        placeImages = await locationService.fetchImages(for: [location])
//                    }
//                }
//            }
//            .onChange(of: searchResults) { newValue in
//                if !newValue.isEmpty {
//                    isSheetPresented = true
//                }
//            }
//            .sheet(isPresented: $isSheetPresented) {
//                UnifiedSheetView(
//                    searchResults: $searchResults,
//                    selectedLocation: $selectedLocation,
//                    placeImages: $placeImages
//                )
//            }
//            .onAppear {
//                
//                if let location = location {
//                    cameraPosition = MapCameraPosition.region(
//                        MKCoordinateRegion(
//                            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
//                            span: MKCoordinateSpan(latitudeDelta: 0.36, longitudeDelta: 0.36)
//                        )
//                    )
//                }
//            }
//    }
//
//    private var mapView: some View {
//        Map(position: $cameraPosition, selection: $selectedLocation) {
//            ForEach(searchResults) { result in
//                Marker(coordinate: result.location) {
//                    Image(systemName: "mappin.circle.fill")
//                        .foregroundColor(.red)
//                        .font(.title)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    SearchableMap()
//}
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
    @State private var placeImages: [URL?] = []
    
    @State private var isSheetPresented: Bool = true
    
    var location: SavedLocation?

    var body: some View {
        NavigationStack{
            VStack{
                mapView
                    .ignoresSafeArea()
                    .onChange(of: selectedLocation) { newValue in
                        if let location = newValue {
                            Task {
                                placeImages = await locationService.fetchImages(for: [location])
                            }
                        }
                    }
                    .onChange(of: searchResults) { newValue in
                        if !newValue.isEmpty {
                            isSheetPresented = true
                        }
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        UnifiedSheetView(
                            searchResults: $searchResults,
                            selectedLocation: $selectedLocation,
                            placeImages: $placeImages
                        )
                    }
                    .onAppear {
                        // Center map on the saved location if provided
                        if let location = location {
                            cameraPosition = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                    span: MKCoordinateSpan(latitudeDelta: 0.36, longitudeDelta: 0.36)
                                )
                            )
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)

            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("Mapa")
            }
    }

    private var mapView: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            if let location = location {
                Marker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                .tag(location)
            }
        }
    }
}

#Preview {
    SearchableMap()
}
