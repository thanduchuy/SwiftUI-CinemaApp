//
//  Order.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Order : Identifiable{
    var id : String = ""
    var name : String = ""
    var image : String = ""
    var uid : String = ""
    var total : Int = 0
    var date : Date = Date()
    var foods : [Food] = [Food]()
    var seats : [Seat] = [Seat]()
}
