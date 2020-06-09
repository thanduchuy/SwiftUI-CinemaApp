//
//  BookSubmit.swift
//  Cinema
//
//  Created by MacBook Pro on 4/9/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookSubmit : View {
    @State var film = Film()
    @State var selected =  Date()
    @State var choose =  [Seat]()
    @State var foods = [Food]()
    @State var isActive : Bool = false
    @Binding var isShow : Bool
    func totalMoney() -> Int {
        return (choose.count * 5) + foods.reduce(0) { (Result, Food) -> Int in
            return Result + (Food.count*Food.price)
        }
        
    }
    var body : some View {
        VStack(spacing:10) {
            ScrollView(.vertical, showsIndicators: false) {
                Text("Check and Pay for Tickets")
                    .foregroundColor(Color.orange)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Progress(width: Float(UIScreen.main.bounds.width-60))
                
                VStack {
                    AnimatedImage(url: URL(string: film.image))
                        .resizable()
                        .frame(height: 200)
                    VStack {
                        Text(film.name).font(.headline)
                        Text(film.time).font(.subheadline)
                    }.foregroundColor(.white)
                }.background(Color.orange.opacity(0.8)).cornerRadius(10)
                VStack(alignment: .leading) {
                    if self.foods.filter({ (Food) -> Bool in
                        return Food.count > 0
                    }).count != 0 {
                        Text("Foods").font(.headline).bold().foregroundColor(.orange)
                        ForEach(0..<self.foods.count,id: \.self) { i in
                            VStack {
                                if self.foods[i].count > 0 {
                                    HStack(spacing: 10) {
                                        AnimatedImage(url: URL(string: self.foods[i].image))
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            Text("Name : \(self.foods[i].name)")
                                            Text("Count : \(self.foods[i].count)")
                                        }.foregroundColor(.orange)
                                        Spacer()
                                        Text("\(self.foods[i].count*self.foods[i].price)$").foregroundColor(.orange)
                                        
                                    }
                                    .padding()
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.orange, lineWidth: 1)
                                    )
                                }
                            }
                        }
                    }
                }.padding(.vertical, 10)
                VStack(alignment: .leading) {
                    Text("Tickets").font(.headline).bold().foregroundColor(.orange)
                    ForEach(0..<self.choose.count,id: \.self) { i in
                        HStack(spacing: 10) {
                            Image("ticket")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Row : \(self.choose[i].row)")
                                Text("Colum : \(self.choose[i].colum)")
                            }.foregroundColor(.orange)
                            Spacer()
                            Text("5$").font(.title).foregroundColor(.orange)
                        }
                        .padding()
                        .overlay (
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                    }
                }
                VStack(alignment: .leading) {
                    Text("The total amount you have to pay is: \(totalMoney())$")
                        .font(.title)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                    HStack(spacing: 10)  {
                        Button(action: {
                            self.isActive.toggle()
                        }) {
                            Image(systemName: self.isActive ? "checkmark.square" : "square")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Text("Agree to the Terms and Services")
                        Spacer()
                    }.foregroundColor(.orange)
                        .padding(.vertical, 10)
                }
                
                Button(action: {
                    addTickets(film: self.film, seats: self.choose, foods: self.foods.filter({ (Food) -> Bool in
                        return Food.count > 0
                    }),date: self.selected,totalMoney: self.totalMoney())
                    self.isShow.toggle()
                }) {
                    Text("Pay Now").foregroundColor(.white)
                }.padding()
                    .background(
                        self.isActive ? Color.orange.opacity(0.6) : Color.black.opacity(0.6)
                )
                    .cornerRadius(500).shadow(color:  self.isActive ? Color.orange.opacity(0.6) : Color.black.opacity(0.6), radius: 10, x: 2, y: 2)
                    .disabled(!self.isActive)
            }
        }.padding()
    }
}
