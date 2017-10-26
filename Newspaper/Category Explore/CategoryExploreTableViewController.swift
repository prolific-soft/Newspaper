//
//  CategoryExploreTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/26/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class CategoryExploreTableViewController: UITableViewController {

    //Class Properties
    let numberOfSections = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Numeber of section from datasource for section 1
        return section == 0 ? 1 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.searchTableViewCell.rawValue, for: indexPath) as! SearchTableViewCell
        }else if indexPath.section == 1  {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.categoryExploreTableViewCell.rawValue, for: indexPath) as! CategoryExploreTableViewCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let cell = cell as? CategoryExploreTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 59
        }else {
            return 250
        }
    }
    

}

extension CategoryExploreTableViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoryExploreCollectionViewCell.rawValue, for: indexPath)  as! CategoryExploreCollectionViewCell
        return cell
    }
    
}
