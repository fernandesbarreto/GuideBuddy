//
//  MapView.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 29/08/24.
//

import SwiftUI
import MapKit

// Efeito de blur do swipe
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(name: "Recife", coordinate: CLLocationCoordinate2D(latitude: -8.050000, longitude: -34.90000))
]

struct MapView: View {
    // Isso aqui embaixo eh só pra começar em Recife
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.050000, longitude: -34.90000),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    @State private var searchText = ""
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height * 0.4
    @State private var previousOffsetY: CGFloat = UIScreen.main.bounds.height * 0.4
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $position) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: location.coordinate)
                }
            }
            .ignoresSafeArea()
            
            VStack {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 40, height: 6)
                    .padding(.top, 8)
                
                searchBar
                    .padding(.top, 8)
                
                Spacer()
                optionsGrid
                    .padding(.bottom, 4)
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height * 0.5)
            .background(VisualEffectBlur(blurStyle: .systemMaterial))
            .cornerRadius(16)
            .offset(y: offsetY + dragOffset.height)
            .gesture(
                DragGesture()
                    .updating($dragOffset, body: { (value, state, _) in
                        state = value.translation
                    })
                    .onEnded { value in
                        let snapDistance = UIScreen.main.bounds.height * 0.25
                        if value.translation.height < -snapDistance {
                            offsetY = 0
                        } else if value.translation.height > snapDistance {
                            offsetY = UIScreen.main.bounds.height * 0.4
                        } else {
                            offsetY = previousOffsetY
                        }
                        previousOffsetY = offsetY
                    }
            )
        }
    }
    
    private var searchBar: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                )
                .padding(.horizontal, 16)
        }
    }

    private var optionsGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ForEach(1...8, id: \.self) { i in
                VStack {
                    Circle()
                        .fill(Color(.systemGray4))
                        .frame(width: 60, height: 60)
                    Text("Opção\(i)")
                        .font(.footnote)
                }
                .padding(5)
            }
        }
    }
}

#Preview {
    MapView()
}
