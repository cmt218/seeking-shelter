//
//  WebService.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/20/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//  Adopted from https://gist.github.com/cmoulton/7ddc3cfabda1facb040a533f637e74b8

import Foundation

final class WebService {
    private let scriptPath = "https://script.google.com/macros/s/AKfycbz3Z6tcEdfoUb1xbzY0NDKrOKgDHcGydxQKzzyynA_7KYEz_No/exec"

    func makeGetCall() {
        // Set up the URL request
        guard let url = URL(string: scriptPath) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            print(responseData)
            // parse the result as JSON, since that's what the API provides
            do {
                let locations = try JSONDecoder().decode(ShelterLocationsList.self, from: responseData)
                // let's just print it to prove we can access it
                print("Object")
                print(locations)
                
            } catch let error {
                print("error trying to convert data to JSON")
                print(error)
                return
            }
        }
        task.resume()
    }
    
    func getStaticData() -> ShelterLocationsList? {
        do {
            guard let urlPath = Bundle.main.url(forResource: "CompressedLocationList", withExtension: "json") else {
                print("Cannot find file")
                return nil
            }
            //try print( String(contentsOf: urlPath, encoding: .utf8) )
            let jsonData = try Data(contentsOf: urlPath)
            let locations = try JSONDecoder().decode(ShelterLocationsList.self, from: jsonData)
            return locations
        } catch let error {
            print(error)
        }
        
        print("Error decoding Location object")
        return nil
    }

}
