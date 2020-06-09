//
//  Search.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Search: View {
    var body: some View {
        ZStack {
            Color("Color").edgesIgnoringSafeArea(.all)
            SearchView().padding(.top)
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
