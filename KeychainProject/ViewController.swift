//
//  ViewController.swift
//  KeychainProject
//
//  Created by Lucas Coelho on 8/13/16.
//  Copyright © 2016 Lucas Coelho. All rights reserved.
//

import UIKit
import Locksmith

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveIntoKeychain() throws {
        try Locksmith.saveData(["some key": "some value"], forUserAccount: "myUserAccount")
        throw LocksmithError.Undefined
    }
}

