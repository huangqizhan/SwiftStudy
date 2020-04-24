//
//  HRecomdHeaderCell.swift
//  SwiftStudy
//
//  Created by hjb_mac_mini on 2019/12/15.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import FSPagerView

protocol HRecomdHeaderCellDelegate : NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String)
    func recommendHeaderBannerClick(url:String)
}

class HRecomdHeaderCell: UICollectionViewCell {
    private var HSquardCellId = "HSquardCellId"
    private var HRecomNewsCollectionViewCellId = "HRecomNewsCollectionViewCelld"
    
    private var focuc : HFocusModel?
    private var square : [HSquareModel]?
    private var topBuzzList : [HTopBuzzModel]?
    
    weak var delegate : HRecomdHeaderCellDelegate?
    
    private lazy var pageView : FSPagerView  = {
        let pg = FSPagerView()
        pg.delegate = self
        pg.dataSource = self
        pg.interitemSpacing = 15
        pg.automaticSlidingInterval = 3.0
        pg.isInfinite = true
        pg.transformer = FSPagerViewTransformer(type: .linear)
        pg.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PageViewCellId")
        return pg
    }()

    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.backgroundColor = UIColor.white
        collectionV.register(HSquardCell.self, forCellWithReuseIdentifier: HSquardCellId)
        collectionV.register(HRecomNewsCollectionViewCell.self, forCellWithReuseIdentifier: HRecomNewsCollectionViewCellId)
        return collectionV
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupLayOut()
    }
    func setupLayOut() {
        // 分页轮播图
        self.addSubview(self.pageView)
        self.pageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        // 九宫格
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pageView.snp.bottom)
            make.height.equalTo(210)
        }
        self.pageView.itemSize = CGSize.init(width: HScreenWidth - 60, height: 140)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var focusModel : HFocusModel?{
        didSet{
            guard let model = focusModel else { return }
            self.focuc = model
            self.pageView.reloadData()
        }
    }
    
    var squarList : [HSquareModel]?{
        didSet{
            guard let list = squarList else { return }
            self.square = list
            self.collectionView.reloadData()
        }
    }
    
    var topBuzzListData : [HTopBuzzModel]?{
        didSet{
            guard let list = topBuzzListData else{return}
            self.topBuzzList = list
            self.collectionView.reloadData()
        }
    }
    
}


extension HRecomdHeaderCell : FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focuc?.data?.count ?? 0;
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let pageCell : FSPagerViewCell =  pageView.dequeueReusableCell(withReuseIdentifier: "PageViewCellId", at: index)
        pageCell.imageView?.kf.setImage(with: URL(string: (self.focuc?.data?[index].cover)!)!)
        return pageCell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:String = self.focuc?.data?[index].link ?? ""
        delegate?.recommendHeaderBannerClick(url: url)
    }
}

extension HRecomdHeaderCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return self.square?.count ?? 0
        }else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let squareCell : HSquardCell = collectionView.dequeueReusableCell(withReuseIdentifier: HSquardCellId, for: indexPath) as! HSquardCell
            squareCell.square = self.square?[indexPath.row]
            return squareCell
        }else{
            let newCell : HRecomNewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecomNewsCollectionViewCellId, for: indexPath) as! HRecomNewsCollectionViewCell
            newCell.topBuzzList = self.topBuzzList
            return newCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if indexPath.section == 0{
             return CGSize.init(width: (HScreenWidth - 5)/5, height:80)
         }else {
             return CGSize.init(width: HScreenWidth, height: 50)
         }
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let string = self.square?[indexPath.row].properties?.uri else {
             let categoryId:String = "0"
             let title:String = self.square?[indexPath.row].title ?? ""
             let url:String = self.square?[indexPath.row].url ?? ""
             delegate?.recommendHeaderBtnClick(categoryId:categoryId,title:title,url:url)
             return
         }
         let categoryId:String = getUrlCategoryId(url:string)
         let title:String = self.square?[indexPath.row].title ?? ""
         let url:String = self.square?[indexPath.row].url ?? ""
         delegate?.recommendHeaderBtnClick(categoryId:categoryId,title:title,url:url)
     }
    
    func getUrlCategoryId(url:String) -> String {
          // 判断是否有参数
          if !url.contains("?") {
              return ""
          }
          var params = [String: Any]()
          // 截取参数
          let split = url.split(separator: "?")
          let string = split[1]
          // 判断参数是单个参数还是多个参数
          if string.contains("&") {
              // 多个参数，分割参数
              let urlComponents = string.split(separator: "&")
              // 遍历参数
              for keyValuePair in urlComponents {
                  // 生成Key/Value
                  let pairComponents = keyValuePair.split(separator: "=")
                  let key:String = String(pairComponents[0])
                  let value:String = String(pairComponents[1])
                  
                  params[key] = value
              }
          } else {
              // 单个参数
              let pairComponents = string.split(separator: "=")
              // 判断是否有值
              if pairComponents.count == 1 {
                  return "nil"
              }
              
              let key:String = String(pairComponents[0])
              let value:String = String(pairComponents[1])
              params[key] = value as AnyObject
          }
          return params["category_id"] as! String
      }
}

