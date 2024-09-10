//
//  SheetView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import SwiftUI
import MapKit

struct SheetView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    @Binding var searchResults: [SearchResult]
    
    @State private var selectedDetent: PresentationDetent = .height(80) // Track the current sheet height state

    var body: some View {
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
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(80), .medium], selection: $selectedDetent)
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
    }

    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
                selectedDetent = .height(80)
            }
        }
    }
}

struct SheetPlaceView: View {
    @Environment(\.dismiss) private var dismiss
    
    let location: SearchResult
    let images: [URL?]

    var body: some View {
        NavigationView {
            VStack {
                Text("\(location.title)")
                    .font(.title2)
                    .padding()

                if images.isEmpty {
                    Text("Nenhuma imagem disponível")
                        .foregroundColor(.gray)
                } else {
                    ScrollView(.horizontal) {
                        HStack (alignment: .center) {
                            ForEach(images.compactMap { $0 }, id: \.self) { url in
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 320, height: 320)
                                .cornerRadius(10)
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Descrição do local")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
            .onAppear() {
                print("images are \(images)")
            }
        }
    }
}

#Preview {
    SheetPlaceView(location: SearchResult(location: CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813), title: "Baixada Fluminense", subTitle: "Baixada Fluminense", placeID: nil), images: [])
}
