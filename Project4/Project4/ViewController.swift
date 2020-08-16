//
//  ViewController.swift
//  Project4
//
//  Created by Saurabh Deshpande on 8/14/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    //properties
    var webView: WKWebView!
    var progressView: UIProgressView!
    var website: String!
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openPage(actionTitle: website)
        //create two uibarbutton items and add to toolbaritems and show toolbaritems
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        //back and forward buttons
        let goBackButton = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForwardButton = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
        
        //create a progress view
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [goBackButton, goForwardButton, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        //set the forward and backward navigation gesture
        webView.allowsBackForwardNavigationGestures = true
        
        //add an observer to for new value of the estimatedProgress
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func openPage(actionTitle: String) {
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        var allowedSite = false
        
        if let host = url?.host {
            for website in websites {
                print("website:-> " + website)
                if host.contains(website) {
                    decisionHandler(.allow)
                    allowedSite = true
                    print("allowedHost-> " + host)
                    return
                }
            }
        } else {
            print("host is nil")
        }
        
        if allowedSite == false {
            if let host = url?.host {
                print("notAllowedHost-> " + host)
                let am = UIAlertController(title: "Website Blocked", message: "The website you are trying to access is blocked", preferredStyle: .alert)
                am.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: navigateBack))
                present(am, animated: true)
            }
        }
        
        print("cancelling the load of website")
        
        decisionHandler(.cancel)
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func navigateBack(action: UIAlertAction! = nil) {
        webView.goBack()
    }
    
    
    
}

