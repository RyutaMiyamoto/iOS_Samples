//
//  ViewController.swift
//  UIActivityViewSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapShareButton(_ sender: UIButton) {
        let activityItems = ["item1", "item2"]
        let activity = CustomActivity()
        activity.url = URL(string: "https://www.google.co.jp/")
        let applicationActivities: [UIActivity] = [activity]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        let excludedActivityTypes: [UIActivityType] = [.saveToCameraRoll, .openInIBooks]
        activityViewController.excludedActivityTypes = excludedActivityTypes
        
        present(activityViewController, animated: true, completion: nil)
    }
}

class CustomActivity: UIActivity {
    
    var url: URL?
    
    override var activityType: UIActivityType? {
        return UIActivityType(rawValue: "SafariOpen")
    }
    
    override var activityTitle: String? {
        return "Open Safari"
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: "image.png")
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        super.prepare(withActivityItems: activityItems)
    }
    
    override func perform() {
        self.activityDidFinish(true)
    }
    
    override func activityDidFinish(_ completed: Bool) {
        super.activityDidFinish(completed)
        
        guard let url = url, UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
