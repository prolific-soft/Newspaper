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
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true
        
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
            if let starsTableViewController = segue.destination as? StarsTableViewController {

                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExploreOpenTableViewCell
                starsTableViewController.articles = (cell?.articles)!
                guard let title = cell?.source?.name else { return }
                starsTableViewController.navigationItem.title = title
            }
            
            if let subcriptionSourceOpenTableViewController = segue.destination as? SubcriptionSourceOpenTableViewController {
                guard let indexPath = sender as? NSIndexPath else { return }
                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExploreOpenTableViewCell
                if let titleName = cell?.source?.name {
                    subcriptionSourceOpenTableViewController.navigationItem.title = titleName
                }
                subcriptionSourceOpenTableViewController.articles = (cell?.articles)!
                subcriptionSourceOpenTableViewController.source = cell?.source!
            }
        }
    }// End prepare for segue
}

extension ExploreOpenTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.toSourceOpen.rawValue, sender: indexPath)
    }
}














