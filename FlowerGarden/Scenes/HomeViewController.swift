//
//  ViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    var nowPage: Int = 0
    
    let dataArray: Array<UIImage> = [UIImage(named: "Banner_0")!, UIImage(named: "Banner_1")!, UIImage(named: "Banner_2")!]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupLayouts()
        bannerTimer()
        
    }

}

extension HomeViewController {
    func setupLayouts() {
        
        bannerCollectionView.layer.cornerRadius = 8.0
        bannerCollectionView.clipsToBounds = true
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    // CollectionView 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // CollectionView Cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCollectionViewCell", for: indexPath) as! HomeBannerCollectionViewCell
        cell.imageView.image = dataArray[indexPath.row]
        
        return cell
    }
    
    // CollectioView 2초 이동 후 감속 메서드
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    // 3초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == dataArray.count-1 {
        // 맨 처음 페이지로 돌아감
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
}
