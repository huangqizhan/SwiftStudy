//
//  HRecomdFooterView.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HRecomdFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.backgroundColor = HDownColor

           self.setupFooterView()
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       func setupFooterView() {
           
       }
}
