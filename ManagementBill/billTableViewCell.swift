//
//  billTableViewCell.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class billTableViewCell: UITableViewCell {
    //---Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shipDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    //---Paramater
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
