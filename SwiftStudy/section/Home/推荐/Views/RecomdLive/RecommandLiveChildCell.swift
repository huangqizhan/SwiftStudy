//
//  RecommandLiveChildCell.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class RecommandLiveChildCell: UICollectionViewCell {
    private var imageV : UIImageView = {
        let imageV = UIImageView.init()
        return imageV
    }()
    private var titleLabel : UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    private var cotentLb : UILabel = {
        let lb = UILabel.init()
        lb.textColor = UIColor.gray
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    private var categerLb : UILabel = {
        let lb = UILabel.init()
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.orange
        return lb
    }()
    
    private var replicationLayer : ReplicatorLayer = {
        let layer = ReplicatorLayer.init(frame:CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }
    func setUpUI(){
          self.addSubview(self.imageV)
          self.imageV.layer.masksToBounds = true
          self.imageV.layer.cornerRadius = 8
          self.imageV.snp.makeConstraints { (make) in
              make.left.top.right.equalToSuperview()
              make.bottom.equalToSuperview().offset(-60)
          }
          self.imageV.addSubview(self.categerLb)
          self.categerLb.layer.masksToBounds = true
          self.categerLb.layer.cornerRadius = 4
          self.categerLb.snp.makeConstraints { (make) in
              make.right.equalToSuperview().offset(-5)
              make.bottom.equalToSuperview().offset(-5)
              make.width.equalTo(30)
              make.height.equalTo(20)
          }
          
          self.addSubview(self.titleLabel)
          self.titleLabel.snp.makeConstraints { (make) in
              make.left.right.equalToSuperview()
              make.top.equalTo(self.imageV.snp.bottom)
              make.height.equalTo(20)
          }
          
          self.addSubview(self.cotentLb)
          self.cotentLb.snp.makeConstraints { (make) in
              make.left.right.equalToSuperview()
              make.top.equalTo(self.titleLabel.snp.bottom)
              make.height.equalTo(40)
              make.bottom.equalToSuperview()
          }
          
          self.imageV.addSubview(self.replicationLayer)
          self.replicationLayer.snp.makeConstraints { (make) in
              make.left.equalToSuperview().offset(10)
              make.bottom.equalToSuperview().offset(-10)
              make.width.equalTo(20)
              make.height.equalTo(10)
          }
      }
      
    
    var liveModel:HLiveModel? {
        didSet{
            guard let model = liveModel else { return }
            if model.coverMiddle != nil {
                self.imageV.kf.setImage(with: URL(string: model.coverMiddle!)!)
            }
            self.titleLabel.text = model.name
            self.cotentLb.text = model.name
            self.categerLb.text = model.categoryName
        }
    }
    
    
    var recommandLiveModel : HLiveModel? {
        didSet{
            guard let model = recommandLiveModel else {
                return
            }
            if model.coverMiddle != nil {
                self.imageV.kf.setImage(with: URL(string: model.coverMiddle!)!)
            }
            self.titleLabel.text = model.name
            self.cotentLb.text = model.name
            self.categerLb.text = model.categoryName 
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
