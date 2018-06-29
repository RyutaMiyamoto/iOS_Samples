//
//  ViewController.swift
//  HomeScreenQuickActionsSample
//
//  Created by RyutaMiyamoto on 2018/06/29.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tapAddButton(_ sender: UIButton) {
        let title = "ActionTitle"
        let subTitle = "ActionSubTitle"
        let type = "ActionType"
        let icon = UIApplicationShortcutIcon(type: .add)
        //let icon = UIApplicationShortcutIcon(templateImageName: "Image")
        let userInfo = ["key1": "value1", "key2": "value2"]
        
        let shortcut = UIMutableApplicationShortcutItem(type: type, localizedTitle: title,
                                                        localizedSubtitle: subTitle, icon: icon, userInfo: userInfo)
        UIApplication.shared.shortcutItems = [shortcut]
    }
    
}

