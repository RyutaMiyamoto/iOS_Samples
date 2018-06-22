//
//  ViewController.swift
//  LocalAuthenticationSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBAction func tapAuthenticationButton(_ sender: UIButton) {
        let context = LAContext()
        var error :NSError?
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthentication,
                localizedReason:"Biometric authentication or Passcode", reply: { success, error in
                    if (success) {
                        print("Success")
                    } else {
                        print("Failed")
                    }
            })
        } else {
            print("Authentication function unusable")
        }
    }
    
}
