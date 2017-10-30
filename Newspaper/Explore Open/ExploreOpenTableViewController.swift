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
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
