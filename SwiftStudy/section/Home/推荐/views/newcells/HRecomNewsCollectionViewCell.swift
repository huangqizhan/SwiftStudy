//
//  HRecomNewsCollectionViewCell.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/31.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit

class HRecomNewsCollectionViewCell: UICollectionViewCell {
    
    private var topBuzz:[HTopBuzzModel]?
    
    private var imageView : UIImageView = {
        let imagV = UIImageView.init()
        imagV.image = UIImage(named: "news.png")
        return imagV;
    }()
    
    private lazy  var moreBtn : UIButton = {
       let btn = UIButton.init(type: .custom)
        btn.setTitle("| 更多", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return btn
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init();
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSize(width: HScreenWidth - 150, height: 40)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let collectionView = UICollectionView.init(frame: CGRect(x: 80, y: 5, width: HScreenWidth - 150, height: 40), collectionViewLayout: layout)
        collectionView.contentSize = CGSize(width:HScreenWidth - 150, height: 40)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.register(HRecomNewsCell.self, forCellWithReuseIdentifier: "HRecomNewsCellId")
        return collectionView
    }()
    
    var timer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews()  {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make ) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        self.addSubview(self.collectionView)
    }
    
    var topBuzzList : [HTopBuzzModel]?{
        didSet{
            guard let model = topBuzzList else {return}
            self.topBuzz = model
            self.collectionView.reloadData()
        }
    }
}


extension HRecomNewsCollectionViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HRecomNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HRecomNewsCellId", for: indexPath) as! HRecomNewsCell
        cell.titleLabel.text = self.topBuzz?[indexPath.row%(self.topBuzz?.count)!].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row%(self.topBuzz?.count)!)
    }
    
    func startTimer() {
        let timer = Timer.init(timeInterval: 2.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
        timer.fire();
    }
    
    @objc func nextPage() {
        var currentOffsetY = self.collectionView.contentOffset.y
        currentOffsetY += self.collectionView.bounds.height
        self.collectionView.setContentOffset(CGPoint(x: 0, y: currentOffsetY), animated: true)
    }
    
}


class HRecomNewsCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let lb = UILabel.init()
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.width.height.left.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
