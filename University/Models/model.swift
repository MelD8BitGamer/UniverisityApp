//
//  model.swift
//  University
//
//  Created by Melinda Diaz on 1/2/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation

struct Universities: Codable {
    let stateProvince: String?
    let country: String
    let alphaTwoCode: String
    let webPages: [String]
    let name: String
    let domains: [String]
    
    
    
    enum CodingKeys: String, CodingKey {
        case stateProvince = "state-province"
        case country
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case name
        case domains = "domains"
        
    }
    
    //this function takes in an array of universities and returns a matrix of universities which the elements of the array are group together by countries
    static func getSection(_ arr: [Universities]) -> [[Universities]]{
        // step 1: sort array
        let sortedByCountry = arr.sorted{$0.country < $1.country}
        
        // step 2: get the number of sections
        let numberOfSections: Set<String> = Set(sortedByCountry.map{$0.country})
        
        //step 3: so this is populating your array of with an array of Universities based on the amount of countries (not sure how many countries)
        var matrix = Array(repeating: [Universities](), count: numberOfSections.count)
        
        var currentIndex = 0
        var currentSection = sortedByCountry.first?.country
        
        for school in sortedByCountry {
            if school.country == currentSection {
                matrix[currentIndex].append(school)
            } else {
                currentSection = school.country
                currentIndex += 1
                matrix[currentIndex].append(school)
            }
        }
        return matrix
    }

    
    
    
}
