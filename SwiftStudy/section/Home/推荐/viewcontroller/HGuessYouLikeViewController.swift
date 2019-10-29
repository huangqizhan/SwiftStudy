//
//  HGuessYouLikeViewController.swift
//  SwiftStudy
//
//  Created by 黄麒展 on 2019/10/29.
//  Copyright © 2019 8km. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import Moya
import Result

class HGuessYouLikeViewController: UIViewController {

    var guessYouLike : [HGuessYouLikeModel]?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HGuessCollectionViewCell.self, forCellWithReuseIdentifier: "HGuessCollectionViewCellId")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = "猜你喜欢"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        setUpLoadData()
    }
    
    func setUpLoadData() {
        HHomeRecommondProvider.request(HHomeRecommondApi.guessYouLikeMoreList) { (result : Result<Response, MoyaError>) in
            if case let .success(response) = result{
                let data = try?response.mapJSON()
                let json = JSON(data!);
                let guesslike = JSONDeserializer<HGuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description)
                self.guessYouLike = guesslike as? [HGuessYouLikeModel]
                self.collectionView.reloadData()
            }
        }
    }

}

extension HGuessYouLikeViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guessYouLike?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HGuessCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HGuessCollectionViewCellId", for: indexPath) as! HGuessCollectionViewCell
        cell.guessModel = self.guessYouLike?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: HScreenWidth - 30, height: 120)
    }
}
