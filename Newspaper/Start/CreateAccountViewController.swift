//
//  CreateAccountViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 10/24/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return
        }
        AuthService.signUp(email: emailText, password: passwordText, onSuccess: {
            SVProgressHUD.showSuccess(withStatus: "Success!")
            
        }) { (ErrorMessage) in
            SVProgressHUD.showError(withStatus: ErrorMessage!)
        }
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
