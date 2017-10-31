//
//  NetworkProcessor.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation

//Makes a call to download JSON for a given API

class NetworkProcessor {
    
    //Properties
    let url : URL
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session : URLSession = URLSession(configuration: configuration)
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONObject = ( (Codable?) -> Void  )
    typealias DataHandler = ( (Data?, HTTPURLResponse?, Error?) -> Void  )
    
    //Downloads json for a url
    func downloadJSONFromURL(withStructType: String, _ completion : @escaping JSONObject ){
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        print("Success")
                        if let responseData = data {
                            do{
                                var downloadedObject : Codable?
                                switch withStructType {
                                case "article":
                                    downloadedObject = try JSONDecoder().decode(Article.self, from: responseData)
                                case "articles":
                                   downloadedObject = try JSONDecoder().decode(Articles.self, from: responseData)
                                    print("Articles was downloaded")
                                case "source":
                                   downloadedObject = try JSONDecoder().decode(Source.self, from: responseData)
                                case "sources":
                                   downloadedObject = try JSONDecoder().decode(Sources.self, from: responseData)
                                default:
                                    print("No conformable case was found!")
                                }
                                 completion(downloadedObject)
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
    
    //Downloads ImageData from URL
    func downloadImageDataFromURL( _ completion : @escaping DataHandler ){
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        print("Success downloading Image")
                        if let responseData = data {
                            completion(responseData, nil, nil)
                        }
                    default:
                        return
                    }
                }
            }else {
                completion(nil, nil, error!)
            }
        }
        dataTask.resume()
    }
    
    
    
    
}// End class NetworkProcessor
