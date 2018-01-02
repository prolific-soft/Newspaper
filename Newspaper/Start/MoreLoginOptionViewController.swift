//
//  MoreLoginOptionViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/24/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class MoreLoginOptionViewController: UIViewController {

    @IBOutlet weak var createAccountButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cutomizeButton()
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
    
    
    func cutomizeButton(){
        createAccountButton.layer.borderWidth = 1.4
        createAccountButton.layer.cornerRadius = 4
        createAccountButton.layer.borderColor = UIColor(red: 61/255, green: 148/255, blue: 255/255, alpha: 1).cgColor
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
