//
//  HomeRecomLiveCell.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON


class HomeRecomLiveCell: UICollectionViewCell {
    
    private var live:[HLiveModel]?
    private var RecommondLiecCellId  = "RecommcondCellId";
    private lazy var changeBtn:UIButton = {
        let btn = UIButton.init(type: .custom);
        btn.setTitle("换一批", for: .normal);
        btn.setTitleColor(HButtonColor, for: .normal);
        btn.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(changeBtnAction(button:)), for: .touchUpInside)
        return btn
    }();
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let colletionV = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        colletionV.delegate = self
        colletionV.dataSource = self
        colletionV.alwaysBounceVertical = true
        colletionV.backgroundColor = UIColor.white
        colletionV.register(RecommandLiveChildCell.self, forCellWithReuseIdentifier: RecommondLiecCellId)
        return colletionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUp();
    }
    func setUp() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // set data
    var listData : [HLiveModel]?{
        didSet{
            guard let model = listData else {return}
            self.live = model
            self.collectionView.reloadData()
        }
    }
    @objc func changeBtnAction(button:UIButton) {
        HHomeRecommondProvider.request(.changeLiveList) { (result) in
            if case let .success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data ?? "");
                if let listModel = JSONDeserializer<HLiveModel>.deserializeModelArrayFrom(json: json["data"]["list"].description){
                    self.live = listModel as? [HLiveModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeRecomLiveCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.live?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommondLiecCellId, for: indexPath) as! RecommandLiveChildCell
        cell.recommandLiveModel = self.live?[indexPath.row]
        return cell
    }
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (HScreenWidth - 55)/3, height: 180)
    }
}
