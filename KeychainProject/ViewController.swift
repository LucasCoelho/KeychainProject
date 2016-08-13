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
    
    let ChosenKey = "some key"
    let ChosenAccount = "myUserAccount"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldDomainState = context.evaluatedPolicyDomainState
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveIntoKeychain() {
        createStringAndSaveIntoKeychain()
    }
    
    func createStringAndSaveIntoKeychain() {
        guard let dictionary = Locksmith.loadDataForUserAccount(ChosenAccount), let _ = dictionary[ChosenKey] else {
            do {
                try Locksmith.saveData([ChosenKey: "some value"], forUserAccount: ChosenAccount)
            } catch {
                LocksmithError.Undefined
            }
            return
        }
    }
    
    @IBAction func checkIfFingerprintWasAdded() {
        context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil)
        
        if let domainState = context.evaluatedPolicyDomainState where domainState != oldDomainState {
            timestamp = NSDate().timeIntervalSince1970
        }
    }
    
    @IBAction func sendJSONMessage() {
        
        guard let dictionary = Locksmith.loadDataForUserAccount(ChosenAccount), let value = dictionary[ChosenKey], let timestamp = timestamp else { return }
        
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

