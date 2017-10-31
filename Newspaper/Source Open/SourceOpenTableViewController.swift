//
//  SourceOpenTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/30/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class SourceOpenTableViewController: UITableViewController {

    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        print("*&&&*********000000000************&&&&&")
        print("Fourth Articles Loaded")
        print("\(articles)")
        print("*&&&*********000000000************&&&&&")
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.sourceOpenTableViewCell.rawValue, for: indexPath) as! SourceOpenTableViewCell

        let article = articles[indexPath.row]
        cell.setUp(withArticle: article)
        
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
