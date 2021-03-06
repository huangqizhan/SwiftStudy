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

class HHomeRecommondViewModel: NSObject {
    ///数据模型
    var fmhomeRecommendModel : HHomeRecommondModel?
    var homeRecommendList : [HRecommendModel]?
    
    var recommendList : [HRecommendListModel]?
    
    var focus : HFocusModel?
    
    var squareList : [HSquareModel]?
    
    var topBuzzList : [HTopBuzzModel]?
    
    ///猜你喜欢
    var guessYouLikeList : [HGuessYouLikeModel]?
    
    var paidCategoryList : [HPaidCategoryModel]?
    
    var playlist : [HPlaylistModel]?
    
    var oneKeyListenList : [HOneKeyListenModel]?
    
    var liveList : [HLiveModel]?
    
    ///更新数据回调
    typealias AddDataBlock = () ->Void
    var updateDataBlock : AddDataBlock?
    
}

extension HHomeRecommondViewModel {
   public func refreshDataSourse() {
    /// 首页推荐接口
        HHomeRecommondProvider.request(.recommondList) { (result) in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                print("data = \(String(describing: data))")
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HHomeRecommondModel>.deserializeFrom(json: json.description){
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list;
                    
                    if let recommendList = JSONDeserializer<HRecommendListModel>.deserializeModelArrayFrom(json:json["list"].description){
                        self.recommendList = recommendList as? [HRecommendListModel];
                    }
                    
                    if let focus = JSONDeserializer<HFocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description){
                        self.focus = focus;
                    }
                    
                    
                    if let squre = JSONDeserializer<HSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description){
                        self.squareList = squre as? [HSquareModel];
                    }
                    
                    if let topBuzz = JSONDeserializer<HTopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description){
                        self.topBuzzList = topBuzz as? [HTopBuzzModel];
                    }
                    
                    
                    if let oneKeyListen = JSONDeserializer<HOneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description){
                        self.oneKeyListenList = oneKeyListen as? [HOneKeyListenModel];
                    }
                    
                    
                    if let live = JSONDeserializer<HLiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description){
                        self.liveList = live as? [HLiveModel];
                    }
                    self.updateDataBlock?()
                }
            }
        }
    }
}


//// collectionView 数据
extension HHomeRecommondViewModel{
    func numnerOfSections(collectionView:UICollectionView) -> Int {
        return self.recommendList?.count ?? 0;
    }
    func numOfItemsInSection(sectoin : Int ) -> Int {
        return 1;
    }
    
    /// section 间距
    func insetaForSection(section : Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    /// item 间距
    func minmumInterItemSpacingForSectionAt(section : Int) -> Int {
        return 0;
    }
    
    /// 行间距
    func minMumLineSpacingForSection(section : Int) -> Float {
        return 0;
    }
    
    ///  item 尺寸
<<<<<<< HEAD
//    func sizeForItemAt(indexPath : IndexPath) -> CGSize {
//        let headerAndFooterHeight : Int = 90;
//    }
=======
    func sizeForItemAt(indexPath : IndexPath) -> CGSize {
        let headerAndFooterHeight : Int = 90;
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3;
        let count = self.homeRecommendList?[indexPath.section].list?.count;
        let modualType = self.homeRecommendList?[indexPath.section].moduleType;
        if modualType == "focus"{
            return CGSize(width: HScreenWidth, height: 360)
        }else if modualType == "square" || modualType == "topBuzz"{
            return CGSize(width: 0, height: 0);
        }else if modualType == "guessYouLike" || modualType == "paidCategory" || modualType == "categoriesForLong" || modualType == "cityCategory" || modualType == "live"{
            return CGSize(width: HScreenWidth, height: CGFloat(headerAndFooterHeight + 180*itemNums))
        }else if modualType == "categoriesForShort" || modualType == "playlist" || modualType == "categoriesForExplore"{
            return CGSize(width: HScreenWidth, height: CGFloat(headerAndFooterHeight + 120*count!))
        }else if modualType == "ad"{
            return CGSize(width: HScreenWidth, height: 240)
        }else if modualType == "oneKeyListen"{
            return CGSize(width: HScreenWidth, height: 180);
        }else{
            return CGSize.zero
        }
    }
    /// 分区头视图
    func referenceSizeForHeaderInSection(section:Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return .zero
        }else{
            return CGSize(width: HScreenWidth, height: 40);
        }
    }
    
    /// 分区尾视图
    func referenceSizeForFooterInSection(section : Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: HScreenWidth, height: 10.0)
        }
    }
>>>>>>> cbc7df3e4b92f3c6ed29f0c1f12575db1ecbd64e
}



