//
//  OrderView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var history : HistoryService
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                       VStack {
                           ForEach(history.orders) { i in
                               itemOrder(data: i)
                           }
                       }
            }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
