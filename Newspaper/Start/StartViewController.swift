//
//  StartViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/24/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Sign In Already Existing User
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let tabVC = storyboard.instantiateViewController(withIdentifier: StoryboardID.tabbarViewController.rawValue) as! UITabBarController
            self.present(tabVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func exploreButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
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
