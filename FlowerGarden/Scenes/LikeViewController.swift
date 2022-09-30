//
//  LikeViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit

class LikeViewController: UIViewController {
    
    let titleList = ["두용이의 꽃집", "심두용의 꽃집", "두용이의 꽃다발", "두용쓰 플라워", "두용씨 반가워요"]
    let addressList = ["서울특별시 동대문구 장안동", "서울특별시 성동구 행당동", "서울특별시 노원구 월계동", "서울특별시 종로구 숭인동", "서울특별시 성동구 마장동"]
    let likeCount = ["좋아요: 10개", "좋아요: 5개", "좋아요: 99개", "좋아요: 57개", "좋아요: 33개"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellMarginSize: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "좋아요 리스트"
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

}

extension LikeViewController: UICollectionViewDelegate {
    
}

extension LikeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as? LikeCollectionViewCell
        
        cell?.titleLabel.text = titleList[indexPath.row]
        cell?.likeLabel.text = likeCount[indexPath.row]
        cell?.addressLabel.text = addressList[indexPath.row]
        
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LikeDetailViewController()
        present(vc, animated: true)
    }
    
    
}

extension LikeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: LikeCollectionViewCell.height)
    }
    
}
