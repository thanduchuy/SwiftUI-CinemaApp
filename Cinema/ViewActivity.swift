//
//  ViewActivity.swift
//  Cinema
//
//  Created by MacBook Pro on 4/11/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ViewActivity: View {
    @EnvironmentObject var activity : ActivitySevice
    var body: some View {
        VStack {
            Text("aa")
        }
    }
}

struct ViewActivity_Previews: PreviewProvider {
    static var previews: some View {
        ViewActivity()
    }
}
