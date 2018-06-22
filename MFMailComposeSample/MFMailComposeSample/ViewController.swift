//
//  ViewController.swift
//  MFMailComposeSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBAction func tapMailButton(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(["test1@test.com"])
        mailComposeViewController.setCcRecipients(["test2@test.com"])
        mailComposeViewController.setBccRecipients(["test3@test.com"])
        mailComposeViewController.setSubject("Title")
        mailComposeViewController.setMessageBody("Message", isHTML: false)
        present(mailComposeViewController, animated: true, completion: nil)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("cancelled")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        case .failed:
            print("failed")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
