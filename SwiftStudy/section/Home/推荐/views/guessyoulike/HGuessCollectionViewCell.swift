//
//  HGuessCollectionViewCell.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/29.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HGuessCollectionViewCell: UICollectionViewCell {
    
    // 图片
    private var picView : UIImageView = {
       let imageView = UIImageView.init()
        return imageView
    }()
    
    /// 标题
    private var titleLb : UILabel = {
        let titLb : UILabel = UILabel()
        titLb.font = UIFont.systemFont(ofSize: 17)
        return titLb
    }()
    /// 是否完结
    private var paidLab : UILabel = {
        let plab = UILabel()
        plab.font = UIFont.systemFont(ofSize: 13)
        plab.textColor = UIColor.white
        plab.backgroundColor = UIColor(red: 248, green: 210, blue: 74, alpha: 1)
        plab.layer.masksToBounds = true
        plab.layer.cornerRadius = 3.0
        plab.textAlignment = NSTextAlignment.center
        return plab
    }()
    
    // 子标题
    private var subTitleLb : UILabel = {
        let sublb = UILabel()
        sublb.font = UIFont.systemFont(ofSize: 15)
        sublb.textColor = UIColor.gray
        return sublb
    }()
    
    /// 播放j数量
    private var bolable : UILabel = {
        let blb = UILabel()
        blb.font = UIFont.systemFont(ofSize: 14)
        blb.textColor = UIColor.gray
        return blb;
    }()
    
    /// 集数
    private var tracksLabel : UILabel = {
        let trlb = UILabel()
        trlb.font = UIFont.systemFont(ofSize: 14)
        trlb.textColor = UIColor.gray
        return trlb
    }()
    
    
    public var guessModel : HGuessYouLikeModel?{
        didSet{
            
        }
    }
    
}
