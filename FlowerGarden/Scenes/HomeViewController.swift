//
//  ViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit
import SnapKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userWelcome: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var nowPage: Int = 0
    
    let dataArray: Array<UIImage> = [UIImage(named: "Banner_0")!, UIImage(named: "Banner_1")!, UIImage(named: "Banner_2")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bannerTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let userInfo = Auth.auth().currentUser?.providerData[0] {
            let user = Auth.auth().currentUser
            if let user = user {
              let uid = user.uid
              let email = user.email
              let photoURL = user.photoURL
              var multiFactorString = "MultiFactor: "
              for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
              }
            }
            userWelcome.text = "\(userInfo.displayName ?? user?.email ?? "고객") 님 환영합니다."
        }
        else {
            userWelcome.text = "OOO 님 환영합니다."
        }
    }
}

//MARK: setupLayout
extension HomeViewController {
    func setupLayout() {
        
        
        bannerCollectionView.layer.cornerRadius = 8.0
        bannerCollectionView.clipsToBounds = true
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 90.0
        
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListTableViewCell", for: indexPath) as? StoreListTableViewCell

        return cell ?? UITableViewCell()
    }
}
