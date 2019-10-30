//
//  HRecomGuessLikeCollectionViewCell.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/30.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HRecomGuessLikeCollectionViewCell: UICollectionViewCell {
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
    
    ///播放数量图片
    private var boNumImageV : UIImageView = {
        let bnV = UIImageView.init()
        bnV.image = UIImage(named: "playcount.png")
        return bnV
    }()
    
    ///集数 图片
    private var tracImageV : UIImageView = {
        let imageV = UIImageView.init()
        imageV.image = UIImage(named: "track.png")
        return imageV;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        self.addSubview(self.picView)
        self.picView.image = UIImage(named: "pic1.jpeg")
        self.picView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        
        self.addSubview(self.paidLab)
        self.paidLab.text = "完结"
        self.paidLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.picView).offset(2)
            make.height.equalTo(16)
            make.width.equalTo(30)
        }
        
        self.addSubview(self.titleLb);
        self.titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(self.paidLab.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.picView)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subTitleLb)
        self.subTitleLb.text = "说服力的积分乐"
        self.subTitleLb.snp.makeConstraints { (make) in
            make.right.height.equalTo(self.titleLb)
            make.left.equalTo(self.picView.snp.right).offset(10)
            make.top.equalTo(self.titleLb.snp.bottom).offset(10)
        }
        
        self.addSubview(self.boNumImageV);
        self.boNumImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.subTitleLb)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(17)
        }
        
        self.addSubview(self.bolable)
        self.bolable.text = "> 2.5亿 1284集"
        self.bolable.snp.makeConstraints { (make) in
            make.left.equalTo(self.boNumImageV.snp.right).offset(5)
            make.bottom.equalTo(self.boNumImageV)
            make.width.equalTo(60)
        }
        self.addSubview(self.tracImageV);
        self.tracImageV.snp.makeConstraints { (make) in
            make.left.equalTo(self.bolable.snp.right).offset(5)
            make.bottom.equalTo(self.bolable)
            make.width.height.equalTo(20)
        }
        
        
        self.addSubview(self.tracksLabel)
        self.tracksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.tracImageV.snp.right).offset(5)
            make.bottom.equalTo(self.tracImageV)
            make.width.equalTo(80)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recommandData : HRecommendListModel?{
        didSet{
            guard let model = recommandData  else {
                return
            }
            if (model.pic != nil){
                self.picView.kf.setImage(with: URL(string: model.pic!))
            }
            if (model.coverPath != nil){
                self.picView.kf.setImage(with: URL(string: model.coverPath!))
            }
            self.titleLb.text = model.title
            self.subTitleLb.text = model.subtitle
            if model.isPaid {
                self.paidLab.isHidden = true
                self.paidLab.snp.makeConstraints { (make) in
                    make.width.equalTo(0)
                }
                self.titleLb.snp.makeConstraints { (make) in
                    make.left.equalTo(self.paidLab.snp.right)
                }
            }
            self.tracksLabel.text = "\(model.tracksCount)集"
            var trackString : String?
            if model.playsCount > 100000000 {
                trackString = String.init(format: "%.1f亿", Double(model.playsCount/100000000))
            }else if model.playsCount > 10000 {
                trackString = String(format: "%.1f万", Double(model.playsCount/10000))
            }else{
                trackString = "\(model.playsCount)"
            }
            self.bolable.text = trackString
        }
    }
    
    public var guessModel : HGuessYouLikeModel?{
        didSet{
            guard let model = guessModel  else {
                return
            }
            if (model.pic != nil){
                self.picView.kf.setImage(with: URL(string: model.pic!))
            }
            if (model.coverMiddle != nil){
                self.picView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLb.text = model.title
            self.subTitleLb.text = model.subtitle
            if model.isPaid {
                self.paidLab.isHidden = true
                self.paidLab.snp.makeConstraints { (make) in
                    make.width.equalTo(0)
                }
                self.titleLb.snp.makeConstraints { (make) in
                    make.left.equalTo(self.paidLab.snp.right)
                }
            }
            self.tracksLabel.text = "\(model.tracksCount)集"
            var trackString : String?
            if model.playsCount > 100000000 {
                trackString = String.init(format: "%.1f亿", Double(model.playsCount/100000000))
            }else if model.playsCount > 10000 {
                trackString = String(format: "%.1f万", Double(model.playsCount/10000))
            }else{
                trackString = "\(model.playsCount)"
            }
            self.bolable.text = trackString
        }
    }
}
