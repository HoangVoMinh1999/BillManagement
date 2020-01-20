//
//  obj_class.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import Foundation
import UIKit

class bill{
    var name:String
    var phone:String
    var product:String
    var quantity:String
    var note:String
    var shipdate:String
    
    init(name:String,phone:String,product:String,quantity:String,note:String,shipdate:String) {
        self.name=name
        self.phone=phone
        self.product=product
        self.quantity=quantity
        self.note=note
        self.shipdate=shipdate
    }
}
