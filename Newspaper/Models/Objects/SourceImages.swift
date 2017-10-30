//
//  SourceImages.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/30/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import Foundation
import UIKit



// TODO:
// MAKES THIS IMAGES TO BE STORED ON FIREBASE
// SO THAT NEW IMAGES FOR SOURCES WITH THE
// RESPECTIVE KEYS CAN BE ADDED IN THE FIREBASE
// STORAGE AND WILL BE UPDATED ACROSS ALL APPS

//The Source Key and its image
class ImageKey {
    
    let image : UIImage
    let key : String
    
    init(image: UIImage, key: String){
        self.image = image
        self.key = key
    }
    
}


// Holds the sources name key defined in the API
// and the image associated with the source
struct SourceImages {
    
    // Returns a list containing the sources and their
    // images
    func getSourceImages() ->  [ImageKey]{
        var list : [ImageKey]
        list =
        [
            ImageKey(image: #imageLiteral(resourceName: "abc-news-au"), key: "abc-news-au"),
            ImageKey(image: #imageLiteral(resourceName: "cnn"), key: "cnn"),
            ImageKey(image: #imageLiteral(resourceName: "al-jazeera-english"), key: "al-jazeera-english"),
            ImageKey(image: #imageLiteral(resourceName: "ars-technica"), key: "ars-technica"),
            ImageKey(image: #imageLiteral(resourceName: "associated-press"), key: "associated-press"),
            ImageKey(image: #imageLiteral(resourceName: "bbc-news"), key: "bbc-news"),
            ImageKey(image: #imageLiteral(resourceName: "bbc-sport"), key: "bbc-sport"),
            ImageKey(image: #imageLiteral(resourceName: "bild"), key: "bild"),
            ImageKey(image: #imageLiteral(resourceName: "bloomberg"), key: "bloomberg"),
            ImageKey(image: #imageLiteral(resourceName: "breitbart-news"), key: "breitbart-news"),
            ImageKey(image: #imageLiteral(resourceName: "business-insider"), key: "business-insider"),
            ImageKey(image: #imageLiteral(resourceName: "business-insider-uk"), key: "business-insider-uk"),
            ImageKey(image: #imageLiteral(resourceName: "buzzfeed"), key: "buzzfeed"),
            ImageKey(image: #imageLiteral(resourceName: "cnbc"), key: "cnbc"),
            ImageKey(image: #imageLiteral(resourceName: "der-tagesspiegel"), key: "der-tagesspiegel"),
            ImageKey(image: #imageLiteral(resourceName: "die-zeit"), key: "die-zeit"),
            ImageKey(image: #imageLiteral(resourceName: "engadget"), key: "engadget"),
            ImageKey(image: #imageLiteral(resourceName: "entertainment-weekly"), key: "entertainment-weekly"),
            ImageKey(image: #imageLiteral(resourceName: "espn-cric-info"), key: "espn-cric-info"),
            ImageKey(image: #imageLiteral(resourceName: "espn"), key: "espn"),
            ImageKey(image: #imageLiteral(resourceName: "financial-times"), key: "financial-times"),
            ImageKey(image: #imageLiteral(resourceName: "focus"), key: "focus"),
            ImageKey(image: #imageLiteral(resourceName: "football-italia"), key: "fooball-italia"),
            ImageKey(image: #imageLiteral(resourceName: "fortune"), key: "fortune"),
            ImageKey(image: #imageLiteral(resourceName: "four-four-two"), key: "four-four-two"),
            ImageKey(image: #imageLiteral(resourceName: "fox-sports"), key: "fox-sports"),
            ImageKey(image: #imageLiteral(resourceName: "google-news"), key: "google-news"),
            ImageKey(image: #imageLiteral(resourceName: "gruenderszene"), key: "gruenderszene"),
            ImageKey(image: #imageLiteral(resourceName: "hacker-news"), key: "hacker-news"),
            ImageKey(image: #imageLiteral(resourceName: "handelsblatt"), key: "handelsblatt"),
            ImageKey(image: #imageLiteral(resourceName: "ign"), key: "ign"),
            ImageKey(image: #imageLiteral(resourceName: "independent"), key: "independent"),
            ImageKey(image: #imageLiteral(resourceName: "mashable"), key: "mashable"),
            ImageKey(image: #imageLiteral(resourceName: "metro"), key: "metro"),
            ImageKey(image: #imageLiteral(resourceName: "mirror"), key: "mirror"),
            ImageKey(image: #imageLiteral(resourceName: "mtv-news"), key: "mtv-news"),
            ImageKey(image: #imageLiteral(resourceName: "mtv-news-uk"), key: "mtv-news-uk"),
            ImageKey(image: #imageLiteral(resourceName: "national-geographic"), key: "national-geographic"),
            ImageKey(image: #imageLiteral(resourceName: "new-scientist"), key: "new-scientist"),
            ImageKey(image: #imageLiteral(resourceName: "new-york-magazine"), key: "new-york-magazine"),
            ImageKey(image: #imageLiteral(resourceName: "newsweek"), key: "newsweek"),
            ImageKey(image: #imageLiteral(resourceName: "nfl-news"), key: "nfl-news"),
            ImageKey(image: #imageLiteral(resourceName: "polygon"), key: "polygon"),
            ImageKey(image: #imageLiteral(resourceName: "recode"), key: "recode"),
            ImageKey(image: #imageLiteral(resourceName: "reddit-r-all"), key: "reddit-r-all"),
            ImageKey(image: #imageLiteral(resourceName: "reuters"), key: "reuters"),
            ImageKey(image: #imageLiteral(resourceName: "spiegel-online"), key: "spiegel-online"),
            ImageKey(image: #imageLiteral(resourceName: "t3n"), key: "t3n"),
            ImageKey(image: #imageLiteral(resourceName: "talksport"), key: "talksport"),
            ImageKey(image: #imageLiteral(resourceName: "techcrunch"), key: "techcrunch"),
            ImageKey(image: #imageLiteral(resourceName: "techradar"), key: "techradar"),
            ImageKey(image: #imageLiteral(resourceName: "the-economist"), key: "the-economist"),
            ImageKey(image: #imageLiteral(resourceName: "the-guardian-au"), key: "the-guardian-au"),
            ImageKey(image: #imageLiteral(resourceName: "the-guardian-uk"), key: "the-guardian-uk"),
            ImageKey(image: #imageLiteral(resourceName: "the-hindu"), key: "the-hindu"),
            ImageKey(image: #imageLiteral(resourceName: "the-huffington-post"), key: "the-huffington-post"),
            ImageKey(image: #imageLiteral(resourceName: "the-lad-bible"), key: "the-lad-bible"),
            ImageKey(image: #imageLiteral(resourceName: "the-new-york-times"), key: "the-new-york-times"),
            ImageKey(image: #imageLiteral(resourceName: "the-next-web"), key: "the-next-web"),
            ImageKey(image: #imageLiteral(resourceName: "the-sport-bible"), key: "the-sport-bible"),
            ImageKey(image: #imageLiteral(resourceName: "the-telegraph"), key: "the-telegraph"),
            ImageKey(image: #imageLiteral(resourceName: "the-times-of-india"), key: "the-times-of-india"),
            ImageKey(image: #imageLiteral(resourceName: "the-verge"), key: "the-verge"),
            ImageKey(image: #imageLiteral(resourceName: "the-wall-street-journal"), key: "the-wall-street-journal"),
            ImageKey(image: #imageLiteral(resourceName: "the-washington-post"), key: "the-washington-post"),
            ImageKey(image: #imageLiteral(resourceName: "time"), key: "time"),
            ImageKey(image: #imageLiteral(resourceName: "usa-today"), key: "usa-today"),
            ImageKey(image: #imageLiteral(resourceName: "wired-de"), key: "wired-de"),
            ImageKey(image: #imageLiteral(resourceName: "wirtschafts-woche"), key: "wirtschafts-woche")
            
            //...
            
            
        ]//End Dict
        return list
    }
    
    
    
    
}// End struct Sourceimages








