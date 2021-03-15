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

extension HHomeRecommendVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numnerOfSections(collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let num = viewModel.numOfItemsInSection(sectoin: section)
//        NSLog("sectoin %ld num = %ld",section,num)
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modulType = viewModel.homeRecommendList?[indexPath.section].moduleType
        NSLog("==== %ld",indexPath.section)
        if modulType == "focus" || modulType == "square" || modulType == "topBuzz" {
            let headerCell : HRecomdHeaderCell = (collectionView.dequeueReusableCell(withReuseIdentifier: HRecomamndHeaderCellId, for: indexPath) as! HRecomdHeaderCell)
            headerCell.focusModel = viewModel.focus
            headerCell.squarList = viewModel.squareList
            headerCell.topBuzzListData = viewModel.topBuzzList
            headerCell.delegate = self
            return headerCell
        }else if modulType == "guessYouLike" || modulType == "paidCategory" || modulType == "categoriesForLong" || modulType == "cityCategory"{
            let gusslikeCell : HRecomGuessLikeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecommandGussYouLikeCellId, for: indexPath) as! HRecomGuessLikeCollectionViewCell
            gusslikeCell.recomlistData = viewModel.homeRecommendList?[indexPath.section].list
            gusslikeCell.delegate = self
            return gusslikeCell
        }else if modulType == "categoriesForShort" || modulType == "playlist" || modulType == "categoriesForExplore"{
            let hotCell : HHotAudioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecommandHotAudioBookCellId , for: indexPath) as! HHotAudioBookCell
            hotCell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            hotCell.delegate = self
            return hotCell
        }else if modulType == "ad"{
            let adCell : HAdviserCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecommandAdverCellId, for: indexPath) as! HAdviserCell
            if indexPath.section == 7 {
                adCell.adModel = self.recommandAdverList?[0]
            }else if indexPath.section == 13{
                adCell.adModel = self.recommandAdverList?[1]
            }
            return adCell
        }else if modulType == "oneKeyListen"{
            let cell : HLaztAdviserCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecommandLazyCellId, for: indexPath) as! HLaztAdviserCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        }else if modulType == "live"{
            let liveCell : HomeRecomLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HRecommandLiveForYouId, for: indexPath) as! HomeRecomLiveCell
            liveCell.listData = viewModel.liveList
            return liveCell
        }else{
            let dCell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return dCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let modulType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : HRecomdHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HRecommandHeaderViewId, for: indexPath) as! HRecomdHeaderView
            return headerView;
        }else if kind == UICollectionView.elementKindSectionFooter{
            let footerView : HRecomdFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HRecommandFooterViewId, for: indexPath) as! HRecomdFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    /// section边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetaForSection(section: section)
    }
    
    ///item最小边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minmumInterItemSpacingForSectionAt(section: section)
    }
    
    /// 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minMumLineSpacingForSection(section: section)
    }
    
    /// item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.sizeForItemAt(indexPath: indexPath)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    
}
// - 点击顶部分类按钮进入相对应界面
extension HHomeRecommendVC : HRecomdHeaderCellDelegate{
    func recommendHeaderBtnClick(categoryId: String, title: String, url: String) {
        
    }
    
    func recommendHeaderBannerClick(url: String) {
        
    }
    
    
}
// - 点击猜你喜欢cell代理方法
extension HHomeRecommendVC : HRecomGuessLikeCollectionViewCellDelegate{
    func recomGuessLikeCollectionViewCellClick(model: HRecommendListModel) {
        
    }
    
    
}
// - 点击热门有声书等cell代理方法
extension HHomeRecommendVC : HHotAudiobookCellDelegate{
    func hotAudiobookCellItemClick(model: HRecommendListModel) {
        
    }
}
