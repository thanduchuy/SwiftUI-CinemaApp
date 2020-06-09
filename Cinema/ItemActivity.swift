//
//  ItemActivity.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemActivity: View {
    @Binding var data : [Activity]
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(self.data) { item in
                        VStack {
                            AnimatedImage(url:URL(string: item.image))
                                .resizable()
                                .frame(width:UIScreen.main.bounds.width-120,height: 460)
                            Text(item.name)
                                .fontWeight(.bold)
                                .padding(.vertical, 13)
                                .padding(.leading)
                        }.background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
            }
            Spacer()
        }.padding()
    }
}

