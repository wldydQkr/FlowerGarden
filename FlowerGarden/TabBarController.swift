//
//  TabBarController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/30.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        let nav = self.navigationController?.navigationBar
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "FlowerGarden_logo") 
        imageView.image = image
        
        navigationItem.titleView = imageView
  

    }
}
