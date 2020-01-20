//
//  billDetailTableViewCell.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/20/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class billDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
