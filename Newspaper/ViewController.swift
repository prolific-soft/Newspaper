//
//  ViewController.swift
//  Newspaper
//
//  Created by Chidi Emeh on 9/22/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dummyView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let one = CustomColor()
        one.customBlue(withFrame: dummyView.frame, view: dummyView)
       //dummyView.backgroundColor
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

