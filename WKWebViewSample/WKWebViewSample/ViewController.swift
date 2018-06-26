//
//  ViewController.swift
//  WKWebViewSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    private let url = URL(string: "https://www.google.co.jp/")
    
    @IBOutlet weak var wkWebView: WKWebView! {
        didSet {
            wkWebView.navigationDelegate = self
        }
    }
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBAction func tapLoadButton(_ sender: UIButton) {
        guard let url = url else { return }
        wkWebView.load(URLRequest(url: url))
    }
    
    @IBAction func tapUpdateButton(_ sender: UIButton) {
        wkWebView.reload()
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        wkWebView.goBack()
    }
    
    @IBAction func tapForwardButton(_ sender: UIButton) {
        wkWebView.goForward()
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("load Start")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateButton.isHidden = false
        backButton.isHidden = !wkWebView.canGoBack
        forwardButton.isHidden = !wkWebView.canGoForward
    }
}
