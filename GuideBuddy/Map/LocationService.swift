//
//  LocationService.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import MapKit

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    var url: URL?
}


struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    private let fixedCoordinate = CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813)
    let regionRadius: CLLocationDistance = 30000

    var completions = [SearchCompletions]()

    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
        
        let region = MKCoordinateRegion(center: fixedCoordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        self.completer.region = region
    }


    func update(queryFragment: String) {
        completer.resultTypes = .pointOfInterest
        completer.queryFragment = queryFragment
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results.compactMap { completion in
            guard let mapItem = completion.value(forKey: "_mapItem") as? MKMapItem,
                  let location = mapItem.placemark.location else {
                return nil
            }

            let userLocation = CLLocation(latitude: fixedCoordinate.latitude, longitude: fixedCoordinate.longitude)
            let distance = userLocation.distance(from: location)
            
            guard distance <= regionRadius else {
                return nil
            }

            return SearchCompletions(
                title: completion.title,
                subTitle: completion.subtitle,
                url: mapItem.url
            )
        }
    }


    func search(with query: String) async throws -> [SearchResult] {
        let mapKitRequest = MKLocalSearch.Request()
        mapKitRequest.naturalLanguageQuery = query
        mapKitRequest.resultTypes = .pointOfInterest

        let region = MKCoordinateRegion(center: fixedCoordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2)
        mapKitRequest.region = region
        
        let search = MKLocalSearch(request: mapKitRequest)
        let response = try await search.start()

        let filteredResults = response.mapItems.filter { mapItem in
            guard let location = mapItem.placemark.location else { return false }
            let userLocation = CLLocation(latitude: fixedCoordinate.latitude, longitude: fixedCoordinate.longitude)
            let distance = userLocation.distance(from: location)

            return distance <= regionRadius
        }

        return filteredResults.map { mapItem in
            let location = mapItem.placemark.location?.coordinate
            return SearchResult(location: location!)
        }

    }
}
