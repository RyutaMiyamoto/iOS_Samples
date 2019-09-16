//
//  ViewController.swift
//  PeekAndPopSample
//
//  Created by RyutaMiyamoto on 2019/09/16.
//  Copyright © 2019 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    // MARK: - UIViewControllerPreviewingDelegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let viewController = UIStoryboard(name: "Peek", bundle: nil).instantiateInitialViewController() else { return nil }
        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        showDetailViewController(viewControllerToCommit, sender: nil)
    }
}
