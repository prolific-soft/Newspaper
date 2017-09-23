//
//  NewsAPIServices.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation


//Builds the strings and makes a call to the API
//using the Network Processor Class

struct NewsAPIServices {
    
    //Properties
    let baseURL = "https://newsapi.org/v1/"
    let APIKey  = "a7d312d111564be8af66634a50ba3e24"
    
    struct searchParameters {
        static let status = "status"
        static let source = "source"
        static let sortBy = "sortBy"
        static let articles = "articles"
    }
    
    struct sortBy {
        static let top = "top"
        static let latest = "latest"
        static let popular = "popular"
    }
    
    
    struct structTypeString {
        static let article = "article"
        static let articles = "articles"
        static let source = "source"
        static let sources = "sources"
    }
 

    typealias JSONResult = ( (Codable?) -> Void  )
    
    func getArticles(source: String, sortBy: String, _ completion : @escaping JSONResult) {
        //https://newsapi.org/v1/articles?source=techcrunch&sortBy=latest&apiKey=a7d312d111564be8af66634a50ba3e24
        let urlString = "\(baseURL)\(searchParameters.articles)?\(searchParameters.source)=\(source)&sortBy=\(sortBy)&apiKey=\(APIKey)"
        let url = URL(string: urlString)
        let articleProcessor = NetworkProcessor(url: url!)
        articleProcessor.downloadJSONFromURL(withStructType: structTypeString.articles) { (jsonData) in
            if let data = jsonData {
               completion(data)
            }
        }

 
        
    }
  
    
    
    
    
    
}//End NewsAPIService
