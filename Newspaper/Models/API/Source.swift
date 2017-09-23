//
//  Source.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//Image size of URL's
struct urlsToLogos: Codable {
    //Properties
    let small: String
    let medium: String
    let large: String
}

//A source of an article as defined
//in the NEWS API

class Source: Codable {
    //Properties
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let urlsToLogos: urlsToLogos
    let sortBysAvailable: [String]
    
}
