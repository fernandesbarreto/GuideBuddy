//
//  LocationService.swift
//  GuideBuddy
//
//  Created by Pedro Fernandes Barreto Costa on 30/08/24.
//

import MapKit
import Foundation
import CoreLocation

struct SearchCompletions: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    var url: URL?
}


struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    let title: String
    let subTitle: String
    let placeID: String?

    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class GooglePlacesService {
    private let apiKey = "AIzaSyAVTheOOGF5wzxX8xte5fsToDRvzHXFM-w"
    
    func getPlaceID(for location: CLLocationCoordinate2D) async throws -> String? {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.latitude),\(location.longitude)&radius=100&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("primeiro erro")
            return nil
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        print("data is \(data)")
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        print("json is \(String(describing: json))")
        
        if let results = json?["results"] as? [[String: Any]], let firstResult = results.first {
            return firstResult["place_id"] as? String
        }

        print("segundo erro")
        return nil
    }

    func getPhotoURL(for placeID: String) async throws -> URL? {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        if let result = json?["result"] as? [String: Any], let photos = result["photos"] as? [[String: Any]], let firstPhoto = photos.first, let photoReference = firstPhoto["photo_reference"] as? String {
            return getGooglePhotoURL(photoReference: photoReference)
        }

        return nil
    }
    
    private func getGooglePhotoURL(photoReference: String) -> URL? {
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(apiKey)"
        return URL(string: urlString)
    }
}


@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    private let fixedCoordinate = CLLocationCoordinate2D(latitude: -8.05428, longitude: -34.8813)
    private let googlePlacesService = GooglePlacesService()
    
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

        var searchResults = [SearchResult]()
        for mapItem in filteredResults {
            let location = mapItem.placemark.location?.coordinate
            let placeID = try await googlePlacesService.getPlaceID(for: location!)
            print("placeID is \(String(describing: placeID))")
            
            searchResults.append(SearchResult(location: location!, title: mapItem.placemark.name ?? "Local", subTitle: mapItem.placemark.subtitle ?? "", placeID: placeID))
        }

        return searchResults
    }

    func fetchImages(for searchResults: [SearchResult]) async -> [URL?] {
        print("to aqui mano")
        var imageUrls = [URL?]()
        for result in searchResults {
            print("iterating with \(String(describing: result.placeID))")
            if let placeID = result.placeID {
                print("opcao 1")
                let photoUrl = try? await googlePlacesService.getPhotoURL(for: placeID)
                imageUrls.append(photoUrl)
            } else {
                print("opcao 2")
                imageUrls.append(nil)
            }
        }
        return imageUrls
    }
}
