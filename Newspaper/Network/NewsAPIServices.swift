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
//return type is based on methods and object return
//is like defined in API
struct NewsAPIServices {
    
    //Properties
    let baseURL = "https://newsapi.org/v1/"
    let APIKey  = ""
    
    //Search parameter keys
    struct searchParameters {
        static let status = "status"
        static let source = "source"
        static let sortBy = "sortBy"
        static let articles = "articles"
    }
    
    //String value of the type of struct to return
    //Structs conforms to Codable
    struct structTypeString {
        static let article = "article"
        static let articles = "articles"
        static let source = "source"
        static let sources = "sources"
    }
 
    typealias JSONResult = ( (Codable?) -> Void  )
    
    //Gets Articles for a given source
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
  
    //Gets Sources from the API
    func getSources(_ completion : @escaping JSONResult) {
        //https://newsapi.org/v1/sources?language=en
        let urlString = "\(baseURL)\(structTypeString.sources)?language=en"
        let url = URL(string: urlString)
        let articleProcessor = NetworkProcessor(url: url!)
        articleProcessor.downloadJSONFromURL(withStructType: structTypeString.sources) { (jsonData) in
            if let data = jsonData {
                completion(data)
            }
        }
    }
    
    
    
    
}//End NewsAPIService
