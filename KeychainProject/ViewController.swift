//
//  ViewController.swift
//  KeychainProject
//
//  Created by Lucas Coelho on 8/13/16.
//  Copyright © 2016 Lucas Coelho. All rights reserved.
//

import UIKit
import Locksmith
import LocalAuthentication

class ViewController: UIViewController {

    var oldDomainState: NSData?
    
    let context = LAContext()

    var timestamp: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldDomainState = context.evaluatedPolicyDomainState

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
    
    func checkIfFingerprintWasAdded() {
        context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil)
        
        if let domainState = context.evaluatedPolicyDomainState where domainState != oldDomainState {
            timestamp = NSDate().timeIntervalSince1970
        }
    }
}

