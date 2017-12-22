//
//  SourceList.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/27/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

/// Creates the list of sources in the API
/// Methods to get the sources into individual Categories

struct SourceList {
    
    //Takes A list of Source then sorts and outputs
    // a dictipnary containing sources
    func sortSourceToCategories(list: [Source]) -> [String : [Source]]{
        var sorted = [String : [Source]]()
        
        for source in list {
            let key = source.category
            var sources = [Source]()
            
            for newSource in list {
                if newSource.category == key {
                    sources.append(newSource)
                }
            }
            sorted[key!] = sources
        }
        return sorted
    }
    

    //Gets the sources from API and article
    func getSources( completion: @escaping ([Source]) -> ()){
        var sources = [Source]()
        let sourceService = NewsAPIServices()
        sourceService.getSources { (result) in
            guard let sourcesResult = result as? Sources else {
                return
            }
            sources = sourcesResult.sources
            completion(sources)
        }
    }
    
    
    
}
