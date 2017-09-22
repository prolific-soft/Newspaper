//
//  NetworkProcessor.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation


class NetworkProcessor {
    
    //Properties
    let url : URL
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session : URLSession = URLSession(configuration: configuration)
    
    init(url: URL) {
        self.url = url
    }
    
    enum StructType {
        case article
        case articles
        case source
        case sources
    }
    
    typealias JSONDictionaryHandler = ( ([String : Any]?)-> Void  )
    
    //Downloads json for a url
    func downloadJSONFromURL(structType: StructType, _ completion : @escaping JSONDictionaryHandler ){
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let responseData = data {
                            do{
//                                
//                                switch structType {
//                                    case .article
//                                default:
//                                    print("Error Matching Struct Type")
//                                }
//                                
//                                 let downloadedObject = try JSONDecoder().decode(structType.self, from: responseData)
//                                let articleList = articles.articles
//                                //completion(downloadedObject)
                            }catch let error as NSError {
                                print("Error decoding: \(error)")
                            }
                        }
                    default:
                        print("Response Status code: \(httpResponse.statusCode)")
                    }
                }
            }else {
                print(error?.localizedDescription ?? "Error downloading task")
            }
            
            
            
        }
        dataTask.resume()
        
        
        
        
    }
    
    
    
    
}
