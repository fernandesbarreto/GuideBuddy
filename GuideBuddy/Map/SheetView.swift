//
//  SheetView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import SwiftUI
import MapKit
import SwiftData

@Model
class SavedLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
}

struct UnifiedSheetView: View {
    @Environment(\.modelContext) private var context
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    @Binding var searchResults: [SearchResult]
    @Binding var selectedLocation: SearchResult?
    @State private var selectedDetent: PresentationDetent = .height(80) // Start collapsed
    @Binding var placeImages: [URL?]
    @Query private var savedLocations: [SavedLocation] // Fetch saved locations directly

    var body: some View {
        VStack {
            if let location = selectedLocation {
                placeDetailView(for: location)
            } else {
                searchView
            }
        }
        .interactiveDismissDisabled()
        .presentationDetents([.height(80), .medium], selection: $selectedDetent)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
    }

    private var searchView: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Procure por algum lugar", text: $search)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: search)) ?? []
                        }
                    }
            }

            Spacer()

            List {
                ForEach(locationService.completions) { completion in
                    Button(action: { didTapOnCompletion(completion) }) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(completion.title)
                                    .font(.headline)
                                    .fontDesign(.rounded)
                                
                                // Show filled or empty star based on save status
                                Button(action: {
                                    toggleSave(for: completion)
                                }, label: {
                                    Image(systemName: isLocationSaved(completion) ? "star.fill" : "star")
                                        .foregroundColor(isLocationSaved(completion) ? .yellow : .primary)
                                })
                            }
                            Text(completion.subTitle)
                            if let url = completion.url {
                                Link(url.absoluteString, destination: url)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .padding()
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
    }

    private func placeDetailView(for location: SearchResult) -> some View {
        VStack{
            Spacer()
            
            HStack {
                Button("Voltar") {
                    selectedLocation = nil
                    selectedDetent = .height(80)
                }
                .padding()
                
                Spacer()
            }

            Text(location.title)
                .font(.title2)
                .padding([.leading, .trailing, .bottom])
                .lineLimit(nil)
                .minimumScaleFactor(0.75)
            
            if let subtitle = location.subTitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.leading, .trailing, .bottom])
            }

            if let url = location.url {
                Link("\(url)", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding([.leading, .trailing, .bottom])
            }

            if placeImages.isEmpty {
                Text("Nenhuma imagem disponível")
                    .foregroundColor(.gray)
                    .padding(.leading)
            } else {
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        ForEach(placeImages.compactMap { $0 }, id: \.self) { url in
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 280, height: 280)
                            .cornerRadius(10)
                            .padding()
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            selectedDetent = .medium
        }
    }

    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
                selectedLocation = singleLocation
                selectedDetent = .medium
            }
        }
    }

    // MARK: - Helper Methods

    private func toggleSave(for completion: SearchCompletions) {
        if let savedLocation = savedLocations.first(where: {
            $0.latitude == completion.latitude && $0.longitude == completion.longitude
        }) {
            // Location is already saved, so remove it
            context.delete(savedLocation)
        } else {
            // Location is not saved, so save it
            let newLocation = SavedLocation(
                name: completion.title,
                latitude: completion.latitude ?? 0,
                longitude: completion.longitude ?? 0
            )
            context.insert(newLocation)
        }
    }

    private func isLocationSaved(_ completion: SearchCompletions) -> Bool {
        return savedLocations.contains(where: {
            $0.latitude == completion.latitude && $0.longitude == completion.longitude
        })
    }
}
