//
//  HHomeViewController.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/7/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import DNSPageView

class HHomeViewController: HBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageStyle()
    }
    func setupPageStyle(){
        let style = DNSPageStyle.init()
        style.isTitleScaleEnabled = false;
        style.isShowBottomLine = true;
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = HButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let viewControllers : [UIViewController] = [
            HHomeRecommendVC(),
            HHomeClassifyVC(),
            HHomeVIPVC(),
            HHomeLiveVC(),
            HHomeBrodcastVC()];
        
        for vc  in viewControllers {
            self.addChild(vc)
        }
        
        let pageView = DNSPageView(frame: CGRect(x: 0, y: HNavBarHeight, width: HScreenWidth, height: HScreenHeight - HNavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.black
        self.view.addSubview(pageView)
    }
}
