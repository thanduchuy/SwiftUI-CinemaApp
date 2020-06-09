//
//  Booking.swift
//  Cinema
//
//  Created by MacBook Pro on 4/7/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Booking: View {
    @State var film = Film()
    @State var selected =  Date()
    @State var choose =  [Seat]()
    @State var foods = [Food]()
    @State var seats = [Seat]()
    @Binding var isShow : Bool
    func checkYourChoose(i:Int,j:Int,arr: [Seat]) -> Bool {
        var result = false
        arr.forEach { (Seat) in
            if Seat.row == i && Seat.colum == j {
                result =  true
            }
        }
        return result
    }
    func checkFormBooking() -> Bool {
        return fomartDaytoDate(date: self.selected) != fomartDaytoDate(date: Date()) && self.choose.count != 0
    }
    var body: some View {
        VStack(spacing : 20) {
            Text("Choose a date and Choose a seat number")
                .foregroundColor(Color.orange)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Progress(width: Float(UIScreen.main.bounds.width/3))
            ScrollView (.horizontal, showsIndicators: false){
                HStack(spacing:10) {
                    ForEach(sortDates(dates: film.movieDay),id: \.self) { i in
                        Button(action: {
                            self.selected = i
                            self.choose = [Seat]()
                        }) {
                            VStack(spacing:10) {
                                Text(fomartDaytoDate(date: i))
                                Text(fomartTimetoDate(date: i))
                            }.padding()
                        }.foregroundColor(self.selected == i ? Color.white : Color.gray)
                            .background(self.selected == i ? Color.orange: Color.clear)
                            .cornerRadius(10)
                    }
                }
            }
            VStack(spacing: 5) {
                ForEach(1...6,id: \.self) { i in
                    HStack(spacing: 10) {
                        ForEach(1...10,id: \.self) { j in
                            VStack {
                                if j == 3 {
                                    Image(systemName: "person.crop.square.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(.leading,20)
                                } else if j == 8 {
                                    Image(systemName: "person.crop.square.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(.trailing,20)
                                }  else {
                                    Image(systemName: "person.crop.square.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        
                                }
                            }.foregroundColor(self.checkYourChoose(i: i, j: j, arr: self.seats.filter(){$0.id == fomartDaytoDate(date: self.selected)}) ? .red : (self.checkYourChoose(i: i, j: j,arr: self.choose) ? .orange : .gray) )
                            .onTapGesture {
                                if self.checkYourChoose(i: i, j: j,arr: self.choose) {
                                    
                                    self.choose = self.choose.filter() {!($0.colum == j && $0.row == i) }
                                } else {
                                    self.choose.append(Seat(id: "", colum: j, row: i))
                                }
                            }
                        }
                    }
                }
            }
            NavigationLink (destination: BookMore(film: self.film,selected: self.selected, choose: self.choose, foods: self.foods,isShow: self.$isShow)) {
                Text("Next Step").foregroundColor(.white)
            }.padding()
            .background(
                self.checkFormBooking() ? Color.orange.opacity(0.6) : Color.black.opacity(0.6)
            )
            .cornerRadius(500).shadow(color:  self.checkFormBooking() ? Color.orange.opacity(0.6) : Color.black.opacity(0.6), radius: 10, x: 2, y: 2)
                .disabled(!checkFormBooking())
            Spacer()
        }.padding()
    }
    
}

