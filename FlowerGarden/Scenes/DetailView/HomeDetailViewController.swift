//
//  HomeDetailViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/15.
//

import UIKit

final class HomeDetailViewController: UIViewController {
    
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
    }
    
    @objc func likeButtonAction() {
        print("좋아요!")
    }
    
}

extension HomeDetailViewController: UITableViewDelegate {
    
}

extension HomeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeDetailTableViewCell", for: indexPath) as? HomeDetailTableViewCell
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }

}
