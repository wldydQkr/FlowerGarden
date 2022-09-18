//
//  UserDetailViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/18.
//

import UIKit

final class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
    
    }
}
