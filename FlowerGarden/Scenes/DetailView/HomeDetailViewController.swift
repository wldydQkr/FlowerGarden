//
//  HomeDetailViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/15.
//

import UIKit

final class HomeDetailViewController: UIViewController {
    
    let menuList = ["해바라기", "튤립", "메리골드", "장미"]
    let menuPrice = ["10,000", "9,000", "7,000", "5,000"]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 90.0
        
        setupNavigationBar()
        
    }
    
    
    
    func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(likeButtonAction))
        
            
            let nav = self.navigationController?.navigationBar
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.contentMode = .scaleAspectFit
            
            let image = UIImage(named: "FlowerGarden_logo") //Your logo url here
            imageView.image = image
            
            navigationItem.titleView = imageView
      
    }
    
    @objc func likeButtonAction() {
        print("좋아요!")
    }
    
}

extension HomeDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "메뉴"
    }
    
}

extension HomeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeDetailTableViewCell", for: indexPath) as? HomeDetailTableViewCell
        cell?.selectionStyle = .none
        
        cell?.nameLabel.text = menuList[indexPath.row]
        cell?.priceLabel.text = menuPrice[indexPath.row]
        
        
        return cell ?? UITableViewCell()
    }

}
