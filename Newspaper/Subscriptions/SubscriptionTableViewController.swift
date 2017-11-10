//
//  SubscriptionTableViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 11/2/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class SubscriptionTableViewController: UITableViewController {

    //class Properties
    var imageCategory = [String : UIImage]()
    var sourceCategories = [String : [Source]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.navigationItem.leftBarButtonItem
        
        loadFakeData()
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return imageCategory.count
        default:
            return 1
        }
    }

    //Deque Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.subscriptionSearchTableViewCell.rawValue, for: indexPath) as! SubscriptionSearchTableViewCell
        }else if indexPath.section == 1  {
            cell = tableView.dequeueReusableCell(withIdentifier: Cell.allArticlesTableViewCell.rawValue, for: indexPath) as! AllArticlesTableViewCell
        }else if indexPath.section == 2  {
           let cell = tableView.dequeueReusableCell(withIdentifier: Cell.subsriptionSourcesTableViewCell.rawValue, for: indexPath) as! SubsriptionSourcesTableViewCell
           
            let key = Array(imageCategory.keys)
            let keyName = key[indexPath.row]
            let image = imageCategory[keyName]

            cell.setUp(sourceName: keyName, sourceImage: image!)
            
            print(keyName)

            return cell
        }
        return cell
    }

    //Temporary Logout User
    //This will be implemented at the Slide Menu
    @IBAction func logoutTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            SVProgressHUD.showError(withStatus: logoutError.localizedDescription)
        }

        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: StoryboardID.startNavigationController.rawValue) as! UINavigationController
        self.present(navController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.exploreOpenToStars.rawValue {
            if let starsTableViewController = segue.destination as? StarsTableViewController {
                
                guard let indexPath = sender as? NSIndexPath else {
                    return
                }

                let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExploreOpenTableViewCell
                starsTableViewController.articles = (cell?.articles)!
            }
        }
    }// End prepare for segue
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadSourcePlusImage() {
        
       // var sourceWithImages = [String : UIImage]()
        //  let loadImages = SourceImages().getSourceImages()
   
    }
    
    func loadFakeData() {
        let ser = SourceList()
        ser.getSources { (sources) in

            let reSources = sources
            let sourceImage = SourceImages().getSourceImages()
            
            for source in reSources {
                for imageObject in sourceImage {
                    if source.id == imageObject.key {
                        self.imageCategory[source.id] = imageObject.image
                    }
                }
            }
            
//            print("??????????????????")
//            print(self.imageCategory.count)
//            print("??????????????????")
        }
        
        //Get source from dict
        
        //create sourceImage dict
        
        //Use source to find images
        
        //get articles for each source to pass to cell
        
    }

}//End class SubscriptionTableViewController



extension SubscriptionTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Segue.exploreOpenToStars.rawValue, sender: indexPath)
    }
    
}
