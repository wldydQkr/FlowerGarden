//
//  UserViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit

class UserViewController: UIViewController {

    let settingsArray = ["Settings", "Notification", "Like", "Help & Support"]
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //TODO: Logout Button Action 만들기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 62.0

    }

}

extension UserViewController: UITableViewDelegate {
    
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        cell?.titleLabel.text = settingsArray[indexPath.row]
        cell?.selectionStyle = .none
        
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return 
    }
    
}
