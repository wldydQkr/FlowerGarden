//
//  UserTableViewCell.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/18.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tableCellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
