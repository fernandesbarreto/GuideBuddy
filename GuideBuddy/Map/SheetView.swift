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
    @State private var selectedDetent: PresentationDetent = .height(80)
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
            Spacer()

            ZStack {
                HStack {
                    Button("Voltar") {
                        selectedLocation = nil
                        selectedDetent = .height(80)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                    
                    Button(action: {
                        print("Tapped")
                    }, label: {
                        Image(systemName: "star")
                    })
                }
            }

            
            Text(location.title)
                .font(.title2)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .trailing, .bottom])
                .lineLimit(nil)
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity)
            
            if let subtitle = location.subTitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding([.leading, .trailing, .bottom])
            }

            if let url = location.url {
                Link("\(url)", destination: url)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.blue)
                    .padding([.leading, .trailing])
                    .lineLimit(nil)
                    .minimumScaleFactor(0.75)
            }

            if placeImages.isEmpty {
                Text("Nenhuma imagem disponível")
                    .foregroundColor(.gray)
                    .padding(.leading)
            } else {
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(placeImages.compactMap { $0 }, id: \.self) { url in
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 240, height: 240)
                            .cornerRadius(10)
                            .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
            }

        }
        .padding()
        .onAppear {
            selectedDetent = .medium
            print("location is \(location)")
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
