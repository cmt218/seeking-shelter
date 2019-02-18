//
//  ShelterLocation.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/20/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import MapKit
import FirebaseFirestore

class ShelterLocation: NSObject, MKAnnotation {
    let timeStamp: String?
    let organizationName: String?
    let category: LocationCategory?
    let website: String?
    let phoneNumber: String?
    let overview: String?
    let street: String?
    let city: String?
    let state: String?
    let zip: String?
    let country: String?
    let fullAddress: String?
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    enum Keys {
        static let timeStamp = "Timestamp"
        static let organizationName = "organizationname"
        static let category = "Category"
        static let website = "Website"
        static let phoneNumber = "Phone"
        static let overview = "Overview"
        static let street = "Address"
        static let city = "City"
        static let state = "State"
        static let zip = "zipcode"
        static let country = "Country"
        static let fullAddress = "fulladdress"
        static let latitude = "Latitude"
        static let longitude = "Longitude"
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        timeStamp = data[Keys.timeStamp] as? String
        organizationName = (data[Keys.organizationName] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        let categoryString = data[Keys.category] as? String
        self.category = ShelterLocation.getCategory(from: categoryString)
        website = data[Keys.website] as? String
        phoneNumber = data[Keys.phoneNumber] as? String
        overview = data[Keys.overview] as? String
        street = data[Keys.street] as? String
        let locationCity = data[Keys.city] as? String ?? ""
        city = (locationCity.isEmpty ? "Other" : locationCity).trimmingCharacters(in: .whitespacesAndNewlines)
        state = data[Keys.state] as? String
        zip = data[Keys.zip] as? String
        country = data[Keys.country] as? String
        fullAddress = data[Keys.fullAddress] as? String
        let latitude = Double(data[Keys.latitude] as? String ?? "0")
        let longitude = Double(data[Keys.longitude] as? String ?? "0")
        coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude ?? 0), longitude: CLLocationDegrees(longitude ?? 0))
        title = organizationName
        subtitle = category?.rawValue
    }
    
    private static func getCategory(from categoryString: String?) -> LocationCategory {
        switch categoryString {
        case "Youth Shelter":
            return LocationCategory.youthShelter
        case "Emergency Shelter":
            return LocationCategory.emergencyShelter
        case "Women Shelter":
            return LocationCategory.womenShelter
        case "Mens Shelter":
            return LocationCategory.mensShelter
        case "Family Shelter":
            return LocationCategory.familyShelter
        case "Food Banks":
            return LocationCategory.foodBank
        case "Medical":
            return LocationCategory.medical
        case "Domestic Violence":
            return LocationCategory.domesticViolence
        case "Veterans":
            return LocationCategory.veterans
        case "Substance Abuse":
            return LocationCategory.substanceAbuse
        default:
            return LocationCategory.other
        }
    }
}

enum LocationCategory: String, Decodable {
    case youthShelter = "Youth Shelter"
    case emergencyShelter = "Emergency Shelter"
    case womenShelter = "Women's Shelter"
    case mensShelter = "Men's Shelter"
    case familyShelter = "Family Shelter"
    case foodBank = "Food Bank"
    case medical = "Medical Resources"
    case domesticViolence = "Domestic Violence Resources"
    case veterans = "Veterans' Aid"
    case substanceAbuse = "Substance Abuse Resources"
    case other = "Other Resources"
}

struct ShelterLocationsList {
    let locations: [ShelterLocation]
    
    init(locations: [ShelterLocation] = []) {
        self.locations = locations
    }
}
