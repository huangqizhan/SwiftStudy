//
//  HHomeRecommendVC.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/7/17.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
///首页推荐 
class HHomeRecommendVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let h = HScreenHeight - HNavBarHeight - 44 - HTabBarHeight;
        let v = UIView(frame: CGRect(x: 100, y: 0, width: 2, height: h))
        v.backgroundColor = UIColor.red
        self.view.addSubview(v)
    }
}
