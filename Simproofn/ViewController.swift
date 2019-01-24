//
//  ViewController.swift
//  Simproofn
//
//  Created by Hamzhya on 23/01/19.
//  Copyright © 2019 Hamzhya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "loginView", sender: self);
        
    }


}

