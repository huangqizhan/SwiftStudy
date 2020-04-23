//
//  HHomeRecommendVC.swift
//  SwiftStudy
//
//  Created by hqz on 2019/7/17.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftyJSON
import HandyJSON

///首页推荐 
class HHomeRecommendVC: UIViewController {
    /// 广告
    private var recommandAdverList : [HRecommnedAdvertModel]?
    
    /// headerId  footerId
    private let HRecommandHeaderViewId = "HRecommandHeaderViewId"
    private let HRecommandFooterViewId = "HRecommandFooterViewId"
    
    /// headerCell
    private let HRecomamndHeaderCellId = "HRecomamndHeaderCellId"
    /// 猜你喜欢
    private let HRecommandGussYouLikeCellId = "HRecommandGussYouLikeCellId"
    /// 热门有声书
    private let HRecommandHotAudioBookCellId = "HRecommandHotAudioBookCellId"
    /// 广告
    private let HRecommandAdverCellId = "HRecommandAdverCellId"
    /// 懒人电台
    private let HRecommandLazyCellId = "HRecommandLazyCellid"
    /// 为你推荐
    private let HRecommandForYouCellId = "HRecommandForYouCellId"
    /// 直播推荐
    private let HRecommandLiveForYouId = "HRecommandLiveForYouId"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        /// footer header
        collectionView.register(HRecomdHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: HRecommandHeaderViewId)
        collectionView.register(HRecomdFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HRecommandFooterViewId )
        
        
        /// 默认
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        ///header cell
        collectionView.register(HRecomdHeaderCell.self, forCellWithReuseIdentifier: HRecomamndHeaderCellId )
        /// 猜你喜欢
        collectionView.register(HRecomGuessLikeCollectionViewCell.self, forCellWithReuseIdentifier: HRecommandGussYouLikeCellId)
        /// 热门有声书
        collectionView.register(HHotAudioBookCell.self, forCellWithReuseIdentifier: HRecommandHotAudioBookCellId)
        /// 广告
        collectionView.register(HAdviserCell.self, forCellWithReuseIdentifier: HRecommandAdverCellId)
        ///懒人电台
        collectionView.register(HLaztAdviserCell.self , forCellWithReuseIdentifier: HRecommandLazyCellId)
        /// 为你推荐
        collectionView.register(HRecomdForYouCell.self, forCellWithReuseIdentifier: HRecommandForYouCellId)
         /// 直播推荐
        collectionView.register(HomeRecomLiveCell.self, forCellWithReuseIdentifier: HRecommandLiveForYouId)
        
        collectionView.uHead = URefreshHeader(refreshingBlock: {
            [weak self] in self?.setupLoadData()
        })
        return collectionView
    }();
    
    lazy var viewModel : HHomeRecommondViewModel = {
        return HHomeRecommondViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
        setupLoadRecommandAdverData()
    }
    /// data
    func setupLoadData() {
        viewModel.updateDataBlock = {
            [unowned self] in
            self.collectionView.uHead.endRefreshing()
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSourse()
    }
    /// 广告数据
    func setupLoadRecommandAdverData() {
        HHomeRecommondProvider.request(.recommondList) { [unowned self] ( result : Result<Moya.Response, MoyaError> ) in
            if case let Result.success(response) = result{
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let adverList = JSONDeserializer<HRecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description){
                    self.recommandAdverList = adverList as? [HRecommnedAdvertModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension HHomeRecommendVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numnerOfSections(collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItemsInSection(sectoin: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modulType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if modulType == "focus" || modulType == "square" || modulType == "topBuzz" {
            let headerCell : HRecomdHeaderCell = (collectionView.dequeueReusableCell(withReuseIdentifier: HRecomamndHeaderCellId, for: indexPath) as! HRecomdHeaderCell)
            headerCell.focusModel = viewModel.focus
            headerCell.squarList = viewModel.squareList
            headerCell.topBuzzListData = viewModel.topBuzzList
            return headerCell
        }
    }
    
    
}
