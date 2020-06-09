//
//  UpdateFood.swift
//  Cinema
//
//  Created by MacBook Pro on 4/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct UpdateFood: View {
    @Binding var showUpdate : Bool
    @EnvironmentObject var cinema: CinemaService
    @State var select = Food()
    @State var showPopup = false
    var body: some View {
        VStack {
             ScrollView(.vertical, showsIndicators: false) {
                 VStack {
                     VStack(spacing : 10) {
                         ForEach(cinema.dataFood) { item in
                             HStack {
                                 Text(item.name)
                                     .padding()
                                     .background(Color.white)
                                     .cornerRadius(30)
                                 Spacer()
                                 Image(systemName: "square.and.pencil")
                                     .resizable()
                                     .frame(width: 15, height: 15)
                                     .padding()
                                     .background(Color.white)
                                     .clipShape(Circle()).onTapGesture {
                                         self.select = item
                                         self.showPopup.toggle()
                                 }
                             }.padding()
                                 .foregroundColor(.orange)
                                 .background(Color.orange.opacity(0.6))
                                 .cornerRadius(10)
                         }
                     }
                 }.padding()
        }.padding()
    }
        .sheet(isPresented: self.$showPopup) {
            PopupFood(show: self.$showPopup,food: self.select)
        }
    }
}
