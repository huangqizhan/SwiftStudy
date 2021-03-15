//
//  HClassifySubMenuModel.swift
//  SwiftStudy
//
//  Created by 8km_mac_mini on 2020/4/27.
//  Copyright © 2020 8km. All rights reserved.
//

import UIKit
import HandyJSON


struct HClassifySubMenuModel : HandyJSON {
    var msg : String?
    var ret : Int = 0
    var gender : String?
    var keyWords : [HClassifySubMenuKeywords]?
    var categoryInfo : HClassifySubMenuCategoryInfo?
    
}


struct HClassifySubMenuKeywords : HandyJSON {
    var categoryId : Int = 0
    var keyWordsId :  Int = 0
    var keyWordsName : String?
    var keyWordsType : Int = 0
    var realCategoryId : Int = 0
}

struct HClassifySubMenuCategoryInfo : HandyJSON{
    var categoryType: Int = 0
    var contentType: String?
    var filterSupported: Bool = false
    var moduleType: Int = 0
    var name: String?
    var title: String?
}


/// 分类二级界面 推荐 Model
struct HClassifyCategoryContentsList: HandyJSON {
    var calcDimension: String?
    var cardClass: String?
    var categoryId:Int = 0
    var contentType: String?
    var hasMore:Bool = false
    var keywordId:Int = 0
    var keywordName: String?
    // var list:[Any]?
    var list:[HClassifyVerticalModel]?
    var loopCount:Int = 0
    var moduleType:Int = 0
    var tagName: String?
    var title: String?
}

struct HClassifyModuleType14Model:HandyJSON {
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare:Bool = false
    var id: Int = 0
    var isExternalUrl: Bool = false
    var properties:HPropertiesModel?
    var sharePic: String?
    var subtitle: String?
    var title: String?
    var url: String?
}

struct HPropertiesModel: HandyJSON {
    var isPaid: Bool = false
    var rankClusterId: Int = 0
}


struct HClassifyVerticalModel:HandyJSON {
    var albumCoverUrl290: String?
    var albumId: Int = 0
    var commentsCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall:String?
    var discountedPrice: Int = 0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var draft: Bool = false
    var id: Int = 0
    var intro:String?
    var isFinished: Int = 0
    var isPaid: Bool = false
    var materialType: String?
    var nickname: String?
    var playsCounts: Int = 0
    var price:CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId:Int = 0
    var priceUnit: String?
    var provider: String?
    var refundSupportType: Int = 0
    var score:CGFloat = 0.0
    var serialState: Int = 0
    var tags: String?
    var title: String?
    var trackId:Int = 0
    var trackTitle: String?
    var tracks:Int = 0
    var uid: Int = 0
    var vipFree: Bool = false
    var vipFreeType: Int = 0
    
    // 14
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare:Bool = false
    // var id: Int = 0
    var isExternalUrl: Bool = false
    var properties:HPropertiesModel?
    var sharePic: String?
    var subtitle: String?
    // var title: String?
    var url: String?
    
    
    // 19
    // var id: Int = 0
    var list: [HClassifyModuleType19List]?
    
    // 20
    // var contentType: Int = 0
    var albums: [HClassifyModuleType20List]?
    var coverPathBig: String?
    var footnote: String?
    // var intro: String?
    // var nickname:String?
    var personalSignature:String?
    var smallLogo:String?
    var specialId:Int = 0
    // var title:String?
    // var uid:Int = 0
    
    
    // 4
    var coverPathSmall:String?
    
    // 16
    var name:String?
}

struct HClassifyModuleType19Model: HandyJSON {
    var id: Int = 0
    var list: [HClassifyModuleType19List]?
}

struct HClassifyModuleType19List: HandyJSON {
    var albumId: Int = 0
    var albumTitle: String?
    var commentsCounts: Int = 0
    var coverSmall: String?
    var createdAt: Int = 0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var duration: Int = 0
    var favoritesCounts: Int = 0
    var id: Int = 0
    var isAuthorized: Bool = false
    var isFree: Bool = false
    var isPaid: Bool = false
    var origin:HClassifyModuleType19Origin?
    var playPath32: String?
    var playPath64: String?
    var playsCounts: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId: Int = 0
    var sampleDuration: Int = 0
    var sharesCounts: Int = 0
    var title: String?
    var trackId: Int = 0
    var uid: Int = 0
}

struct HClassifyModuleType19Origin:HandyJSON {
    var title:String?
    var coverSmall:String?
}

struct HClassifyModuleType20Model: HandyJSON {
    var contentType: Int = 0
    var albums: [HClassifyModuleType20List]?
    var coverPathBig: String?
    var footnote: String?
    var intro: String?
    var nickname:String?
    var personalSignature:String?
    var smallLogo:String?
    var specialId:Int = 0
    var title:String?
    var uid:Int = 0
}

struct HClassifyModuleType20List: HandyJSON {
    var albumCoverUrl290:String?
    var albumId: Int = 0
    var commentsCounts: Int = 0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var id: Int = 0
    var isDraft: Bool = false
    var isPaid: Bool = false
    var intro:String?
    var isFinished: Int = 0
    var lastUptrackAt: Int = 0
    var materialType: String?
    var origin:HClassifyModuleType20Origin?
    var playsCounts: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId: Int = 0
    var priceUnit: String?
    var score: Int = 0
    var serialState: Int = 0
    var title: String?
    var tracksCounts: Int = 0
}

struct HClassifyModuleType20Origin: HandyJSON {
    var albumCoverUrl290: String?
    var title:String?
}
