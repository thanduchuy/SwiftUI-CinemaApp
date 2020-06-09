//
//  DetailOrder.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailOrder: View {
    @State var foods = [Food]()
    @State var seats = [Seat]()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Foods").font(.headline).bold().foregroundColor(.orange)
            ForEach(0..<self.foods.count,id: \.self) { i in
                VStack(alignment: .leading) {
                    HStack(spacing: 10) {
                        AnimatedImage(url: URL(string: self.foods[i].image))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Name : \(self.foods[i].name)")
                            Text("Count : \(self.foods[i].count)")
                        }.foregroundColor(.orange)
                        
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                }.padding()
            }
            VStack(alignment: .leading) {
                Text("Tickets").font(.headline).bold().foregroundColor(.orange)
                ForEach(0..<self.seats.count,id: \.self) { i in
                    HStack(spacing: 10) {
                        Image("ticket")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("Row : \(self.seats[i].row)")
                            Text("Colum : \(self.seats[i].colum)")
                        }.foregroundColor(.orange)
                        Spacer()
                    }
                    .padding()
                    .overlay (
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.orange, lineWidth: 1)
                    )
                }
            }.padding()
        }.padding()
    }
}


