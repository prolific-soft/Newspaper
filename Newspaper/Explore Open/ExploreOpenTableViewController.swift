//
//  ExploreOpenTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/27/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class ExploreOpenTableViewController: UITableViewController {

    var sourceList = [Source]()
    var newsSource : Source!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.exploreOpenTableViewCell.rawValue, for: indexPath) as! ExploreOpenTableViewCell
        
        let source = sourceList[indexPath.row]
        cell.setUp(withSource: source)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toSourceOpen.rawValue {
            if let sourceOpenTableViewController = segue.destination as? SourceOpenTableViewController {

                guard let indexPath = sender as? NSIndexPath else {
                    return
                }
                
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExploreOpenTableViewCell
                if let newSource = cell?.source {
                    let tempService = NewsAPIServices()
                    tempService.getArticles(source: newSource.id, sortBy: "top", { (result) in
                        guard let sourceResult = result as? Articles else {return}
                        
                        DispatchQueue.main.async {
                            let articles = sourceResult.articles
                            sourceOpenTableViewController.articles = articles
                        }
                        
                    })
                }
                
                
            }
        }
    }// End prepare for segue

}

extension ExploreOpenTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.toSourceOpen.rawValue, sender: indexPath)
    }
    
}














