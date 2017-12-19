//
//  SubsriptionSourcesTableViewCell.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class SubsriptionSourcesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceCountLabel: UILabel!
    
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
    

    func setUp(source : Source){
        self.source = source
        self.sourceNameLabel.text = source.name
        loadArticlesForSources(withource: source)
    }
    
    func loadArticlesForSources(withource: Source) {
        let downloader = NewsAPIServices()
        downloader.getArticles(source: withource.id!, sortBy: "top", { (result) in
        guard let downloadedArticles = result as? Articles else {return}
        
        DispatchQueue.main.async {
            self.articles = downloadedArticles.articles
            self.sourceCountLabel.text =  "\(self.articles?.count ?? 0)"
            }
        })
    }

}
