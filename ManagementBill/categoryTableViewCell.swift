//
//  categoryTableViewCell.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 2/15/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell {
    //---Variable
    //---Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    //---Action
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
