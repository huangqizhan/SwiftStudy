//
//  HGuessCollectionViewCell.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/29.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HGuessCollectionViewCell: UICollectionViewCell {
    
    /// 图片
    private var imageView : UIImageView = {
        let imgV = UIImageView.init()
        return imgV;
    }()
    /// 标题
    private var titleLb : UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb;
    }()
    
    /// 子标题
    private var subTitleLb : UILabel = {
       let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setupSubViews()  {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        self.addSubview(self.titleLb)
        self.titleLb.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subTitleLb);
        self.subTitleLb.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLb.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
    }
    
    var recommandListModel : HRecommendListModel?{
        didSet{
            guard let model = recommandListModel else {
                return
            }
            if model.pic != nil {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLb.text = model.title
            self.subTitleLb.text = model.subtitle
        }
    }
    
    
    
}
