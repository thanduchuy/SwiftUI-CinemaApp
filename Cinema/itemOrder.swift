//
//  itemOrder.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct itemOrder: View {
    @State var data : Order
    @State var isShow = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AnimatedImage(url:URL(string: data.image))
                .resizable()
                .frame(height: 350)
            .cornerRadius(10)
            HStack(spacing: 15) {
                Button(action: {
                    self.isShow.toggle()
                }) {
                    Image(systemName: "exclamationmark.square.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                VStack {
                    if data.date > Date() {
                        Image("check")
                            .resizable()
                            .frame(width: 50, height: 50)
                    } else {
                        Image("close")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }.padding()
                    .background(Color.white)
                .clipShape(Circle())
            }.padding()
                .foregroundColor(Color.white)
        }
        .padding()
        .sheet(isPresented: self.$isShow) {
            DetailOrder(foods: self.data.foods, seats: self.data.seats)
        }
        
    }
}
