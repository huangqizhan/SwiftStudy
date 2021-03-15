//
//  HHomeRecommongViewModel.swift
//  SwiftStudy
//
//  Created by hqz on 2019/7/18.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HHomeRecommongViewModel: NSObject {
    ///数据模型
    var fmhomeRecommendModel : HHomeRecommondModel?
    var homeRecommendList : [HRecommendModel]?
    
    var recommendList : [HRecommendListModel]?
    
    var focus : HFocusModel?
    
    var squareList : HSquareModel?
    
    var topBuzzList : HTopBuzzModel?
    
    ///猜你喜欢
    var guessYouLikeList : HGuessYouLikeModel?
    
    var paidCategoryList : HPaidCategoryModel?
    
    var playlist : HPlaylistModel?
    
    var oneKeyListenList : HOneKeyListenModel?
    
    var liveList : HLiveModel?
    
    ///更新数据回调
    typealias AddDataBlock = () ->Void
    var updateDataBlock : AddDataBlock?
    
}

extension HHomeRecommongViewModel {
   public func refreshDataSourse() {
        HHomeRecommondProvider.request(.recommondList) { (result) in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                print("data = \(String(describing: data))")
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HHomeRecommondModel>.deserializeFrom(json: json.description){
                    self.fmhomeRecommendModel = mappedObject
                    
                }
            }
        }
    }
}
