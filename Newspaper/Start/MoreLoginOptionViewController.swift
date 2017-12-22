//
//  MoreLoginOptionViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/24/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class MoreLoginOptionViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    @IBAction func emailLoginButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func createAccountLoginTapped(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.toolbar.isHidden = true
        //self.navigationController?.navigationBar.isHidden = true
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
