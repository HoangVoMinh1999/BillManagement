//
//  class_obj.swift
//  ManagementBill
//
//  Created by Vo Minh Hoang on 1/16/20.
//  Copyright © 2020 Vo Minh Hoang. All rights reserved.
//

import UIKit

class Bill {
    @objc dynamic var name:String
    @objc dynamic var phone:String
    @objc dynamic var product:Array<String> = []
    @objc dynamic var quantity:Array<String> = []
    @objc dynamic var note:String = ""
    @objc dynamic var shipdate:String
    @objc dynamic var status:Bool
    
    init(name:String,phone:String,product:Array<String>,quantity:Array<String>,note:String,shipdate:String,status:Bool) {
        self.name=name
        self.phone=phone
        self.product=product
        self.quantity=quantity
        self.note=note
        self.shipdate=shipdate
        self.status=status
    }
}
