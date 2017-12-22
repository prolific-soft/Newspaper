//
//  ExploreOpenTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/27/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class ExploreOpenTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var sourceDescription: UILabel!
    @IBOutlet weak var subscriberCount: UILabel!
    @IBOutlet weak var articleCount: UILabel!
    
    //Class Properties
    var source : Source?
    var articles : [Article]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(withSource : Source){
        
        //Set selected Source
        self.source = withSource
        
        let list = SourceImages().getSourceImages()
        sourceImageView.image = UIImage() // Clears Image memory so no repeats
        
        sourceTitle.text = withSource.name
        sourceDescription.text = withSource.description
        
        for item in list {
            if(withSource.id == item.key){
                sourceImageView.image = item.image
            }
        }
        
        //Circlar Image
        //sourceImageView.layer.borderWidth = 0.25
        sourceImageView.layer.masksToBounds = false
        sourceImageView.layer.borderColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5).cgColor
        
        sourceImageView.layer.cornerRadius = sourceImageView.frame.height/2
        sourceImageView.layer.shadowRadius = CGFloat(6)
        sourceImageView.layer.shadowOpacity = 5
        sourceImageView.layer.shadowOffset = CGSize(width: 0, height: 7)
        sourceImageView.layer.shadowColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        sourceImageView.clipsToBounds = true
        
        loadArticles(sourceID: withSource.id!)
        
    }
    
    func loadArticles(sourceID: String){
        let tempService = NewsAPIServices()
        tempService.getArticles(source: sourceID, sortBy: "top", { (result) in
            guard let sourceResult = result as? Articles else { return }
            DispatchQueue.main.async {
                let articles = sourceResult.articles
                self.articles = articles
            }
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
