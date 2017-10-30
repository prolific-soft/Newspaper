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
    var collectionViewItems = 9
    var height = CGFloat()
    var imageCategory = [String : UIImage]()
    var sourceCategories = [String : [Source]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = self.tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //Init Image Categories
        imageCategory = ["Business" :  UIImage(named: "business")!, "Entertainment" :  UIImage(named: "entertainment")! ,
        "Gaming" :  UIImage(named: "gaming")!, "General" :  UIImage(named: "general")!, "Music" :  UIImage(named: "music")!, "Politics" :  UIImage(named: "politics")!, "Science" :  UIImage(named: "science")!, "Sports" :  UIImage(named: "sports")!, "Tech" :  UIImage(named: "tech")!]
        collectionViewItems = imageCategory.count
        
        
        let ser = SourceList()
        ser.getSources { (sources) in
            let newSorted = SourceList()
            let comp = newSorted.sortSourceToCategories(list: sources)
            self.sourceCategories = comp
            print("+++++++++++++++++++++++++++")
            print(comp)
            print("+++++++++++++++++++++++++++")
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Numeber of section from datasource for section 1
        return section == 0 ? 1 : 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toExploreOpen" {
            if let exploreOpenTableViewController = segue.destination as? ExploreOpenTableViewController {
                //let keys = Array(imageCategory.keys)
                let cell = sender as! CategoryExploreCollectionViewCell
               
                //let keyName = keys[(sender as! IndexPath).row]
                let selectedCategory = sourceCategories[ cell.categoryLabel.text!.lowercased()]
//                
//                print("================== 1 ======================")
//                print("\(cell.categoryLabel.text!.lowercased())")
//                 print("==========================================")
//                
//                print("===============   2   ===============")
//                print("\(selectedCategory?.description)")
//                print("===================================")
//            
                
                if let sourceCat = selectedCategory {
                    exploreOpenTableViewController.sourceList = sourceCat
                }
                
                
            }
        }
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
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 2.5
        
        let numberOfItemsPerRow : CGFloat = 2.0
        let itemWidth = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        
        return CGSize(width: itemWidth, height: height)
        
    }
    
}


extension CategoryExploreTableViewController
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: "toExploreOpen", sender: indexPath)
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         self.performSegue(withIdentifier: "toExploreOpen", sender: indexPath)
//    }
}
