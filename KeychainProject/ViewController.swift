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


typealias JSONDictionary = [String: AnyObject]

class ViewController: UIViewController {

    var oldDomainState: NSData?
    
    let context = LAContext()

    var timestamp: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldDomainState = context.evaluatedPolicyDomainState
        sendJSONMessage()
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
    
    func sendJSONMessage() {
        
        guard let dictionary = Locksmith.loadDataForUserAccount("myUserAccount"), let value = dictionary["some key"] else { return }
        
        let jsonDict = ["randomstring": value , "newfinger": timestamp]
        
        let url = NSURL(string: "https://requestb.in/wo6pi2wo")!
        
        let resource = Resource(url: url, method: .post(jsonDict), parseJSON: { result in
            print("parse result:\(result)")
        })
        Webservice().load(resource) { (result) in
            print(result)
        }
    }
}

