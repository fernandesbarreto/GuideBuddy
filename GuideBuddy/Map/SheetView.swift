//
//  SheetView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct UnifiedSheetView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    @Binding var searchResults: [SearchResult]
    @Binding var selectedLocation: SearchResult?
    @State private var selectedDetent: PresentationDetent = .height(80) // Start collapsed
    @Binding var placeImages: [URL?]

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
                            Text(completion.title)
                                .font(.headline)
                                .fontDesign(.rounded)
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
        VStack {
            Text(location.title)
                .font(.title2)
                .padding()

            if placeImages.isEmpty {
                Text("Nenhuma imagem disponível")
                    .foregroundColor(.gray)
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
            Button("Voltar para busca") {
                selectedLocation = nil
                selectedDetent = .height(80)
            }
            .padding(.top, 8)
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
}
