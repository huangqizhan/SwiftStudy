//
//  HLaztAdviserCell.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HLaztAdviserCell: UICollectionViewCell {
   private var oneKeyListen:[HOneKeyListenModel]?
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.setTitleColor(HButtonColor, for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    // - 懒加载九宫格分类按钮
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (HScreenWidth - 45) / 3, height:120)
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HLaztAdviserChildCell.self, forCellWithReuseIdentifier: "LBOneKeyListenCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    // 布局
    func setUpLayout(){
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(button:UIButton){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var oneKeyListenList:[HOneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            self.oneKeyListen = model
            self.gridView.reloadData()
        }
    }
}

extension HLaztAdviserCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HLaztAdviserChildCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneKeyListenCell", for: indexPath) as! HLaztAdviserChildCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }
}
