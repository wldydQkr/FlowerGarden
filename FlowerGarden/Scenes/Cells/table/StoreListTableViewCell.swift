//
//  StoreListTableViewCell.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/15.
//

import UIKit

class StoreListTableViewCell: UITableViewCell {
    
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet weak var storeImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
