//
//  HClassifySubRecommandViewModel.swift
//  SwiftStudy
//
//  Created by 8km_mac_mini on 2020/4/27.
//  Copyright © 2020 8km. All rights reserved.
//

import UIKit

/// 添加数据
typealias HAddDateBlock = ()->Void

class HClassifySubRecommandViewModel : NSObject {
    
    var categoryId : Int = 0
    
    convenience init(category : Int = 0 ) {
        self.init()
        self.categoryId = category
    }
    
    var classifyCategroyContentlist : [HClassifyCategoryContentsList]?
    var classifyModuleType14List:[HClassifyModuleType14Model]?
    var classifyModuleType19List:[HClassifyModuleType19Model]?
    var classifyModuleType20Model:[HClassifyModuleType20Model]?
    var classifyVerticalModel:[HClassifyVerticalModel]?
    var focus:HFocusModel?
    
    
    var updateBlock : HAddDateBlock?
    
}

/// 请求数据
extension HClassifySubRecommandViewModel{
    
}

/// collectionVuew data 
extension HClassifySubRecommandViewModel{
    
}


