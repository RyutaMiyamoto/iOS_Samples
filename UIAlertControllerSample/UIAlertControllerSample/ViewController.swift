//
//  ViewController.swift
//  UIAlertControllerSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapActionSheetButton(_ sender: UIButton) {
        show(style: .actionSheet)
    }
    
    @IBAction func tapAlertButton(_ sender: UIButton) {
        show(style: .alert)
    }
    
    func show(style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: "title", message: nil, preferredStyle: style)
        let action1 = UIAlertAction(title: "action1", style: .default){ (action: UIAlertAction) in
            print("tap action1")
        }
        alertController.addAction(action1)
        
        //
        let action2 = UIAlertAction(title: "action2", style: .default){ (action: UIAlertAction) in
            print("tap action2")
        }
        alertController.addAction(action2)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated: true,completion: nil)
    }
}

