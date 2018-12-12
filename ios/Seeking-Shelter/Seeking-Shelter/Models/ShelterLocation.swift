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
    let id: Int
    let timeStamp: String?
    let isOpen: Bool
    let organizationName: String?
    let category: LocationCategory?
    let tags: [String?]
    let website: String?
    let phoneNumber: String?
    let overview: String?
    let twitterHandle: String?
    let facebookUrl: String?
    let instagramUrl: String?
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
        static let id = "ID"
        static let timeStamp = "Timestamp"
        static let isOpen = "Open"
        static let organizationName = "organizationname"
        static let category = "Category"
        static let tags = "Tags"
        static let website = "Website"
        static let phoneNumber = "Phone"
        static let overview = "Overview"
        static let twitterHandle = "twitterurl"
        static let facebookUrl = "facebookurl"
        static let instagramUrl = "instagramurl"
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
        id = data[Keys.id] as! Int
        timeStamp = data[Keys.timeStamp] as? String
        isOpen = data[Keys.isOpen] as? Bool ?? true
        organizationName = data[Keys.organizationName] as? String
        let categoryString = data[Keys.category] as? String
        self.category = ShelterLocation.getCategory(from: categoryString)
        let tagsString = data[Keys.tags] as? String
        tags = tagsString?.components(separatedBy: ", ") ?? []
        website = data[Keys.website] as? String
        phoneNumber = data[Keys.phoneNumber] as? String
        overview = data[Keys.overview] as? String
        twitterHandle = data[Keys.twitterHandle] as? String
        facebookUrl = data[Keys.facebookUrl] as? String
        instagramUrl = data[Keys.instagramUrl] as? String
        street = data[Keys.street] as? String
        city = data[Keys.city] as? String
        state = data[Keys.state] as? String
        zip = data[Keys.zip] as? String
        country = data[Keys.country] as? String
        fullAddress = data[Keys.fullAddress] as? String
        let latitude = data[Keys.latitude] as? Double ?? 0
        let longitude = data[Keys.longitude] as? Double ?? 0
        coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
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
    case womenShelter = "Women Shelter"
    case mensShelter = "Mens Shelter"
    case familyShelter = "Family Shelter"
    case foodBank = "Food Banks"
    case medical = "Medical"
    case domesticViolence = "Domestic Violence"
    case veterans = "Veterans"
    case substanceAbuse = "Substance Abuse"
    case other
}

struct ShelterLocationsList {
    let locations: [ShelterLocation]
    
    init(locations: [ShelterLocation] = []) {
        self.locations = locations
    }
}
