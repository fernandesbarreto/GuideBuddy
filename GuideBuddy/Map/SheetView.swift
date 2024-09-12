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

    @State private var isLoading = false

    private var searchView: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Procure por algum lugar", text: $search)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            isLoading = true
                            searchResults = (try? await locationService.search(with: search)) ?? []
                            isLoading = false
                        }
                    }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.leading, 8)
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
        VStack(alignment: .leading) {
            Spacer()
            
            HStack {
                Button("Voltar") {
                    selectedLocation = nil
                    selectedDetent = .height(80)
                }
                .padding()

                Spacer()

                Button(action: {
                    print("Tapped")
                }, label: {
                    Image(systemName: "star")
                })
                .padding(.trailing)
            }

            Text(location.title)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing, .bottom])
                .lineLimit(nil)
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let subtitle = location.subTitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .bottom])
            }

            if let url = location.url {
                Link("\(url)", destination: url)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding([.leading, .trailing])
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            if placeImages.isEmpty {
                Text("Nenhuma imagem disponível")
                    .foregroundColor(.gray)
                    .padding(.leading)
            } else {
                ForEach(placeImages.compactMap { $0 }, id: \.self) { url in
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 340, maxHeight: 340)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(10)
                }
            }
        }
        .padding([.top, .bottom])
        .onAppear {
            selectedDetent = .medium
            print("location is \(location)")
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
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
