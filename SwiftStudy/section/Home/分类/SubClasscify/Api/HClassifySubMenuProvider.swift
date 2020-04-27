//
//  HClassifySubMenuProvider.swift
//  SwiftStudy
//
//  Created by 8km_mac_mini on 2020/4/27.
//  Copyright © 2020 8km. All rights reserved.
//

import UIKit
import Moya

//let HClassifySubMenuProvider = Moya<>




public enum HClassifySubMenuAPI{
    case headerCategoryList(categoryId:Int)
    case classifyRecommandList(categoryId:Int)
    case classifyOtherContentList(keywordId : Int , category: Int)
}

extension HClassifySubMenuAPI : TargetType{
    public var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    public var path: String {
        switch self {
        case .headerCategoryList:
            return "/discovery-category/keyword/all/1534468874767"
        case .classifyRecommandList:
            return "/discovery-category/v2/category/recommend/ts-1534469064622"
        case .classifyOtherContentList:
            return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
        }
    }
    
    public var method: Moya.Method {
        return Moya.Method.get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        var parmaters = [String : Any]()
        switch self {
        case .headerCategoryList(let categoryId):
            parmaters = ["device":"iPhone","gender":9]
            parmaters["categoryId"] = categoryId
        case .classifyRecommandList(let categoryId):
            parmaters = ["appid":0,
                         "device":"iPhone",
                         "gender":9,
                         "inreview":false,
                         "network":"WIFI",
                         "operator":3,
                         "scale":3,
                         "uid":124057809,
                         "version":"6.5.3",
                         "xt": Int32(Date().timeIntervalSince1970),
                         "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            parmaters["categoryId"] = categoryId
        case .classifyOtherContentList(let keywordId, let category):
            parmaters = ["calcDimension":"hot",
                                   "device":"iPhone",
                                   "pageId":1,
                                   "pageSize":20,
                                   "status":0,
                                   "version":"6.5.3"]
            parmaters["keywordId"] = keywordId
            parmaters["categoryId"] = category;
        }
        return Task.requestParameters(parameters: parmaters, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
