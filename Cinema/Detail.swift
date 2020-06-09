//
//  Detail.swift
//  Cinema
//
//  Created by MacBook Pro on 4/4/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct Detail: View {
    @State var film  = Film()
    @State var show = false
    @State var rate = 0
    @State var foods = [Food]()
    @Binding var isShow : Bool
    @EnvironmentObject var history : HistoryService
    @EnvironmentObject var activity : ActivitySevice
    @State var idActivity = ""
    func checkActvity() -> Bool {
        var result = false
        self.activity.data.forEach { (item) in
            if item.name == film.name {
                self.idActivity = item.id
                result = true
            }
        }
        return result
    }
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    AnimatedImage(url: URL(string: film.image)!)
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .frame(height: 350)
                    VStack {
                        VStack(spacing:15) {
                            Text(film.name).foregroundColor(.black)
                            HStack(spacing:15) {
                                HStack {
                                    Image(systemName: "star.fill").font(.caption)
                                    Text(String(format: "%.2f", avgRate(arr: film.rate)))
                                }
                                HStack {
                                    Image(systemName: "clock.fill")
                                    Text(film.time)
                                }
                                HStack {
                                    Image(systemName: "heart.circle.fill")
                                    Text("Love")
                                }.foregroundColor(checkActvity() ? .red : Color.black.opacity(0.5))
                                    .onTapGesture {
                                        if self.checkActvity() {
                                            removeActivity(id: self.idActivity)
                                        } else {
                                            addActivity(film: self.film)
                                        }
                                }
                            }
                            Divider().padding(.vertical, 15)
                            Text(film.info).font(.caption)
                        }.padding()
                            .background(Color("Color"))
                            .foregroundColor(Color.black.opacity(0.5))
                            .cornerRadius(25)
                        
                        if self.rate == 0 {
                            Button(action: {
                                self.rate = 0
                                self.show.toggle()
                            }) {
                                VStack {
                                    Image("review").resizable().frame(width: 100, height: 80)
                                    Text("Rate The Movie").font(.caption)
                                }
                            }.padding(.top, 10)
                                .foregroundColor(.orange)
                        } else {
                            Text("Thank you your rate")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        NavigationLink (destination: Booking(film: self.film,foods: self.foods,seats: self.history.data,isShow: self.$isShow)) {
                            Text("Movie Ticket Booking").foregroundColor(.white)
                        }.padding().background(Color.orange.opacity(0.6)).cornerRadius(500).shadow(color: .orange, radius: 10, x: 2, y: 2)
                        Spacer()
                    }.padding(.horizontal, 25)
                        .padding(.top, -35)
                }
                if self.show {
                    GeometryReader { _ in
                        VStack {
                            Rate(rate: self.$rate,show: self.$show,film:self.film).padding()
                        }
                    }.background(Color.black.opacity(0.2)).edgesIgnoringSafeArea(.all)
                }
            }.animation(.default).edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            if self.idActivity.isEmpty {
                self.idActivity = "Anonymous"
            }
            self.history.data = [Seat]()
            self.history.getDataSeats(name: self.film.name)
        }
    }
}
