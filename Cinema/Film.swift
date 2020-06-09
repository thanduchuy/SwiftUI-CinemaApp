//
//  Film.swift
//  Cinema
//
//  Created by MacBook Pro on 4/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Film : Identifiable {
    var id : String = ""
    var name : String = ""
    var image : String = ""
    var time : String = ""
    var info : String = ""
    var rate : [Int] = [Int]()
    var movieDay : [Date] = [Date]()
    var category : [String] = [String]()
}
