//
//  HWebViewController.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/29.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import WebKit

class HWebViewController: UIViewController {
    private var url : String = ""
    
    convenience init(url:String = ""){
        self.init()
        self.url = url
    }
    private lazy var webView : WKWebView = {
        var webView = WKWebView.init(frame: self.view.bounds)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.webView);
        webView.load(URLRequest(url: URL(string: self.url)!))
    }
}
