//
//  BookMore.swift
//  Cinema
//
//  Created by MacBook Pro on 4/8/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookMore: View {
     @State var film = Film()
    @State var selected =  Date()
    @State var choose =  [Seat]()
    @State var foods = [Food]()
     @Binding var isShow : Bool
    var body: some View {
        VStack(spacing:10) {
            Text("Choose Food and Drinks")
                .foregroundColor(Color.orange)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Progress(width: Float(UIScreen.main.bounds.width/2))
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(0..<self.foods.count , id: \.self) { item in
                    HStack {
                        AnimatedImage(url: URL(string: self.foods[item].image))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        VStack(alignment: .leading) {
                            Text(self.foods[item].name.trimmingCharacters(in: .whitespacesAndNewlines)).font(.headline).fontWeight(.bold)
                            Text("\(self.foods[item].price) $").font(.caption)
                        }.foregroundColor(.orange)
                        Spacer()
                        HStack {
                            Button(action: {
                                if self.foods[item].count != 0 {
                                    self.foods[item].count -= 1
                                }
                            }) {
                                Image(systemName: "minus.square.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(self.foods[item].count != 0 ? .orange : .gray)
                            }
                            TextField("Count", value: self.$foods[item].count, formatter: NumberFormatter())
                                .frame(width: 20, height: 20).border(Color.orange, width: 1)
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.center)
                            Button(action: {
                                self.foods[item].count += 1
                            }) {
                                Image(systemName: "plus.square.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.orange)
                            }
                        }
                        }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.orange, lineWidth: 1)
                            .shadow(color: .orange, radius: 10, x: 2, y: 2)
                    ).padding(.top, 10)
                }
            }
            
            NavigationLink (destination: BookSubmit(film: self.film,selected: selected, choose: choose, foods: foods,isShow: self.$isShow)) {
                    Text("Next Step")
                    .foregroundColor(.white)
            }.padding()
            .background(Color.orange.opacity(0.6))
            .cornerRadius(500)
            .shadow(color: .orange, radius: 10, x: 2, y: 2)
        }.padding()
    }
}
