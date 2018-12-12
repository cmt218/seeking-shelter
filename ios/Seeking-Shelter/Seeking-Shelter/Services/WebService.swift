//
//  WebService.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/20/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//  Adopted from https://gist.github.com/cmoulton/7ddc3cfabda1facb040a533f637e74b8

import Foundation
import FirebaseFirestore

final class WebService {
    public static let shared = WebService()
    let database: Firestore
    
    init() {
        database = Firestore.firestore()
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        database.settings = settings
    }
    
    func getLocations(completion: @escaping (ShelterLocationsList) -> Void) {
        var shelterLocationList: [ShelterLocation] = []
        
        database.collection("data").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let location = ShelterLocation(snapshot: document)
                    shelterLocationList.append(location)
                }
                let locationList = ShelterLocationsList(locations: shelterLocationList)
                completion(locationList)
            }
        }
    }
    
}
