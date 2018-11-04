//
//  ShelterLocation.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/20/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import MapKit

class ShelterLocation: NSObject, Decodable, MKAnnotation {
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
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case timeStamp = "Timestamp"
        case isOpen = "Open"
        case organizationName = "Organization Name"
        case category = "Category"
        case tags = "Tags"
        case website = "Website"
        case phoneNumber = "Phone"
        case overview = "Overview"
        case twitterHandle = "Twitter URL"
        case facebookUrl = "Facebook URL"
        case instagramUrl = "Instagram URL"
        case street = "Address"
        case city = "City"
        case state = "State"
        case zip = "Zip Code"
        case country = "Country"
        case fullAddress = "Full Address"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        timeStamp = try values.decode(String.self, forKey: .timeStamp)
        isOpen = try values.decode(Bool.self, forKey: .isOpen)
        organizationName = try values.decode(String.self, forKey: .organizationName)
        category = try values.decode(LocationCategory.self, forKey: .category)
        let tagsString = try values.decode(String.self, forKey: .tags)
        tags = tagsString.components(separatedBy: ", ")
        website = try values.decode(String.self, forKey: .website)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        overview = try values.decode(String.self, forKey: .overview)
        twitterHandle = try values.decode(String.self, forKey: .twitterHandle)
        facebookUrl = try values.decode(String.self, forKey: .facebookUrl)
        instagramUrl = try values.decode(String.self, forKey: .instagramUrl)
        street = try values.decode(String.self, forKey: .street)
        city = try values.decode(String.self, forKey: .city)
        state = try values.decode(String.self, forKey: .state)
        zip = try values.decode(String.self, forKey: .zip)
        country = try values.decode(String.self, forKey: .country)
        fullAddress = try values.decode(String.self, forKey: .fullAddress)
        let latitude = try values.decode(Float.self, forKey: .latitude)
        let longitude = try values.decode(Float.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        title = organizationName
        subtitle = category?.rawValue
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer().decode(String.self)
        self = LocationCategory(rawValue: container) ?? .other
    }
}

struct ShelterLocationsList: Decodable {
    let locations: [ShelterLocation]

    enum CodingKeys: CodingKey {
        case locations
    }
}
