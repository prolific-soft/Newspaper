//
//  Articles.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//Contains a list of articles
//from the news API

struct Articles: Codable {
    let status: String
    let source: String
    let sortBy: String
    let articles: [Article]
}
