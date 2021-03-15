//
//  HRecomGuessLikeCollectionViewCell.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/30.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftyJSON
import HandyJSON


protocol HRecomGuessLikeCollectionViewCellDelegate {
    func recomGuessLikeCollectionViewCellClick(model:HRecommendListModel)
}

class HRecomGuessLikeCollectionViewCell: UICollectionViewCell {
    
    var delegate : HRecomGuessLikeCollectionViewCellDelegate?
    
    private var recommadList : [HRecommendListModel]?
    
    private let gussyoulikeCellId = "gussyoulikeCellId"
    
    private lazy var chnageBtn : UIButton = {
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var colloectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HGuessCollectionViewCell.self, forCellWithReuseIdentifier: gussyoulikeCellId)
        return collectionView
    }()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        self.contentView.addSubview(self.colloectionView)
        self.colloectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        self.contentView.addSubview(self.chnageBtn)
        self.chnageBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    var recomlistData : [HRecommendListModel]?{
        didSet{
            self.recommadList = recomlistData
            self.colloectionView.reloadData()
        }
    }
    
    @objc func updataBtnClick(button:UIButton) {
        HHomeRecommondProvider.request(.changeGuessYouLikeList) { [weak self] ( result : Result<Moya.Response, MoyaError> ) in
            if case let Result.success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let recList = JSONDeserializer<HRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description)
                self?.recommadList = recList as? [HRecommendListModel]
                self?.colloectionView.reloadData()
            }
        }
    }
}

extension HRecomGuessLikeCollectionViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommadList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HGuessCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: gussyoulikeCellId, for: indexPath) as! HGuessCollectionViewCell
        cell.recommandListModel = self.recommadList?[indexPath.row]
        return cell
    }
    //每个分区的内边距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
      }

      //最小 item 间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 5;
      }

      //最小行间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 5;
      }

      //item 的尺寸
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize.init(width:(HScreenWidth - 55) / 3,height:180)
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recomGuessLikeCollectionViewCellClick(model: (self.recommadList?[indexPath.row])!)
    }
}
