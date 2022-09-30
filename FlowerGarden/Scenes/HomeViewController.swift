//
//  ViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit
import Lottie
import Firebase

class HomeViewController: UIViewController {
    
    let animationView: AnimationView = {
        let animationView = AnimationView(name: "women-day-flower-delivery")
        animationView.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
        animationView.contentMode = .scaleAspectFill
        
        return animationView
    }()
    
    let db: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var flowerSection: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var nowPage: Int = 0
    
    let dataArray: Array<UIImage> = [UIImage(named: "Banner_0")!, UIImage(named: "Banner_1")!, UIImage(named: "Banner_2")!]
    
    
    let addressList = ["서울특별시 동대문구 장안동", "서울특별시 성동구 행당동", "서울특별시 노원구 월계동", "서울특별시 종로구 숭인동", "서울특별시 성동구 마장동"]
    let flowerList = ["두용이의 꽃집", "심두용의 꽃집", "두용이의 꽃다발", "두용쓰 플라워", "두용씨 반가워요"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottie()
        
        setupLayout()
        setupNavigationBar()
        bannerTimer()
        
        db.child("titleName").observeSingleEvent(of: .value) { snapshot in
            let firstData = snapshot.value as? String ?? ""
            
            DispatchQueue.main.async {
                self.flowerSection.text = firstData
            }
        }
        
    }

}

//MARK: setupLayout
extension HomeViewController {
    
    func lottie() {
        
        view.addSubview(animationView)
        animationView.center = view.center

        animationView.play { (finish) in
            print("Animation finished!")
            
            self.animationView.removeFromSuperview()
        }
        
        
        
        self.animationView.removeFromSuperview()
    }
    
    func setupNavigationBar() {
        
        let nav = self.navigationController?.navigationBar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "FlowerGarden_logo") //Your logo url here
        imageView.image = image
        
        navigationItem.titleView = imageView
  

    }
    
    func setupLayout() {
        
        
        bannerCollectionView.layer.cornerRadius = 8.0
        bannerCollectionView.clipsToBounds = true
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 70.0
        
        
    }
}

//MARK: CollectionView
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

//MARK: TableView
extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListTableViewCell", for: indexPath) as? StoreListTableViewCell
        
        cell?.selectionStyle = .none
        
        cell?.titleLabel.text = flowerList[indexPath.row]
        cell?.addressLabel.text = addressList[indexPath.row]

        return cell ?? UITableViewCell()
    }
}
