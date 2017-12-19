//
//  AllArticlesTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class AllArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfArticleCountLabel: UILabel!
    
    
    var source : Source?
    var articles : [Article]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUp(sources: [Source]){
        var loadedArticles = [Article]()
        for source in sources {
            let downloader = NewsAPIServices()
            downloader.getArticles(source: source.id!, sortBy: "top", { (result) in
                guard let downloadedArticles = result as? Articles else {return}
                let articleList = downloadedArticles.articles
                
                for article in articleList {
                    loadedArticles.append(article)
                }
    
                DispatchQueue.main.async {
                    self.articles = loadedArticles
                    self.numberOfArticleCountLabel.text = "\(self.articles?.count ?? 0)"
                }
            })
        }
        

        

    }

}
