//
//  ViewController.swift
//  SlideMenuSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rightContainerView: UIView! {
        didSet {
            guard let viewController = UIStoryboard(name: "Right", bundle: nil).instantiateInitialViewController() else { return }
            rightContainerView.frame = rightContainerViewInitFrame
            rightContainerView.addSubview(viewController.view)
        }
    }
    @IBOutlet weak var leftContainerView: UIView! {
        didSet {
            guard let viewController = UIStoryboard(name: "Left", bundle: nil).instantiateInitialViewController() else { return }
            leftContainerView.frame = leftContainerViewInitFrame
            leftContainerView.addSubview(viewController.view)
        }
    }
    
    private let rightContainerViewInitFrame = CGRect(x: UIScreen.main.bounds.size.width, y: 0,
                                                     width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    private let leftContainerViewInitFrame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0,
                                                    width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    private let containerViewDispFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if let view = touch.view {
                transitionSlideViewController(tag: view.tag)
            }
        }
    }
    
    func transitionSlideViewController(tag: Int) {
        if tag == 100 {
            UIView.animate(withDuration: 0.3, animations: {
                self.rightContainerView.frame = self.rightContainerViewInitFrame
            })
        } else if tag == 200 {
            UIView.animate(withDuration: 0.3, animations: {
                self.leftContainerView.frame = self.leftContainerViewInitFrame
            })
        }
    }
    
    @IBAction func tapRightButton(_ sender: UIButton) {
        rightContainerView.frame = rightContainerViewInitFrame
        UIView.animate(withDuration: 0.3, animations: {
            self.rightContainerView.frame = self.containerViewDispFrame
        })
    }
    
    @IBAction func tapLeftButton(_ sender: UIButton) {
        leftContainerView.frame = leftContainerViewInitFrame
        UIView.animate(withDuration: 0.3, animations: {
            self.leftContainerView.frame = self.containerViewDispFrame
        })
    }
}
