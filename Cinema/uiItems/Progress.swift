//
//  Progress.swift
//  Cinema
//
//  Created by MacBook Pro on 4/7/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Progress: View {
    @State var width : Float = 0
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                Capsule().fill(Color.black.opacity(0.2)).frame(height: 20)
            }
            Capsule()
                .fill(LinearGradient(gradient: .init(colors: [Color.orange,Color.yellow]), startPoint: .leading, endPoint: .trailing))
                .frame(width: CGFloat(width), height: 20)
        }.padding()
            .background(Color.black.opacity(0.085))
            .cornerRadius(15)
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        Progress()
    }
}
