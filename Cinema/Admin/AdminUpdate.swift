//
//  AdminUpdate.swift
//  Cinema
//
//  Created by MacBook Pro on 4/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminUpdate: View {
    @Binding var showUpdate : Bool
    @State var active = true
    var body: some View {
        VStack {
            HStack {
                Image("quit")
                    .resizable()
                    .frame(width: 30, height: 30).onTapGesture {
                        self.showUpdate.toggle()
                }
                Spacer()
                Text("Update").font(.largeTitle)
                Spacer()
            }.padding()
                .foregroundColor(.white)
                .background(Color.orange)
            HStack {
                Button(action: {
                    self.active.toggle()
                }) {
                    Text("Film").fontWeight(.bold)
                        .padding()
                        .padding(.horizontal, 40)
                }.background(self.active ? Color("Color") : Color.orange.opacity(0.7))
                .cornerRadius(30)
                 .foregroundColor(self.active ? Color.orange : Color("Color"))
                .overlay(
                       RoundedRectangle(cornerRadius: 30)
                           .stroke(self.active ?   Color.orange.opacity(0.7) : Color("Color"), lineWidth: 1)
                )
                Spacer()
                Button(action: {
                    self.active.toggle()
                }) {
                    Text("Food").fontWeight(.bold)
                        .padding()
                        .padding(.horizontal, 40)
                }.background(self.active ? Color.orange.opacity(0.7):Color("Color"))
                .cornerRadius(30)
                .foregroundColor(self.active ? Color("Color"):Color.orange  )
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(self.active ? Color("Color"):Color.orange.opacity(0.7), lineWidth: 1)
                )
                
            }
            .padding()
                .background(Color.orange)
                .cornerRadius(50)
            .padding( 10)
            GeometryReader { _ in
                if self.active {
                    UpdateFilm(showUpdate: self.$showUpdate)
                } else {
                    UpdateFood(showUpdate: self.$showUpdate)
                }
            }
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

