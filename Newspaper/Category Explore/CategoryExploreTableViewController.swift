//
//  CategoryExploreTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/26/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import SVProgressHUD

class CategoryExploreTableViewController: UITableViewController {

    //Class Properties
    let numberOfSections = 2
    var collectionViewItems = 9
    var height = CGFloat()
    var imageCategory = [String : UIImage]()
    var sourceCategories = [String : [Source]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //self.tableView.setContentOffset(, animated: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.contentOffset.y = self.tableView.contentOffset.y + 58
        self.tableView.scrollsToTop = true
    }
}



//MARK: Load Data
extension CategoryExploreTableViewController {
    func loadData(){
        
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 100))
        SVProgressHUD.show()
        
        //Initialize Image Categories
        imageCategory = ["Business" : UIImage(named: "business")!,
                         "Entertainment" : UIImage(named: "entertainment")!,
                         "Gaming" :  UIImage(named: "gaming")!,
                         "General" :  UIImage(named: "general")!,
                         "Music" :  UIImage(named: "music")!,
                         "Politics" :  UIImage(named: "politics")!,
                         "science-and-nature" :  UIImage(named: "science")!,
                         "Sport" :  UIImage(named: "sports")!,
                         "Technology" :  UIImage(named: "tech")!]
        
        collectionViewItems = imageCategory.count
        
        let ser = SourceList()
        ser.getSources { (sources) in
            let newSorted = SourceList()
            let comp = newSorted.sortSourceToCategories(list: sources)
            self.sourceCategories = comp
        }
        SVProgressHUD.dismiss(withDelay: 1.3)
    }
}



//MARK : - CollectionView Datasource & Delegate
extension CategoryExploreTableViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.categoryExploreCollectionViewCell.rawValue, for: indexPath)  as! CategoryExploreCollectionViewCell
        let keys = Array(imageCategory.keys)
        
        let keyName = keys[indexPath.row]
        cell.setUp(name: keyName, image: imageCategory[keyName]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 3.0  //5.0
        layout.minimumInteritemSpacing = 3.0  //2.5
        
        let numberOfItemsPerRow : CGFloat = 2.0
        let itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        
        return CGSize(width: itemWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.toExploreOpen.rawValue, sender: indexPath)
    }
}





//MARK: - Tableview Datasource
extension CategoryExploreTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 1
    }
}




//MARK: - Tableview Delegate
extension CategoryExploreTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.searchTableViewCell.rawValue, for: indexPath) as! SearchTableViewCell
        }else if indexPath.section == 1  {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.categoryExploreTableViewCell.rawValue, for: indexPath) as! CategoryExploreTableViewCell
        }
        return cell
    }
    
    //Tableview WillDisplay
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let cell = cell as? CategoryExploreTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
                cell.collectionView.isScrollEnabled = false
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            height = 59
        }else if indexPath.section == 1{
            if collectionViewItems == 1 {
                height =  CGFloat((180 * 1))
            }else {
                let mod = collectionViewItems % 2
                let val = mod != 0 ?  (collectionViewItems + 1) / 2 : collectionViewItems / 2
                height = CGFloat((180 * val) + 50)
            }
        }
        return height
    }
}




//MARK: - Prepare for Segue
extension CategoryExploreTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toExploreOpen.rawValue {
            if let exploreOpenTableViewController = segue.destination as? ExploreOpenTableViewController {
                //let keys = Array(imageCategory.keys)
                let cell = sender as! CategoryExploreCollectionViewCell
                let selectedCategory = sourceCategories[cell.categoryLabel.text!.lowercased()]
                if let sourceCat = selectedCategory {
                    exploreOpenTableViewController.sourceList = sourceCat
                    
                    exploreOpenTableViewController.navigationItem.title = cell.categoryLabel.text
                }
            }
        }
    }
}




