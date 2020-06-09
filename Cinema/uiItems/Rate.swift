//
//  Rate.swift
//  Cinema
//
//  Created by MacBook Pro on 4/7/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Rate: View {
    @Binding var rate : Int
    @Binding var show : Bool
    @State var film : Film = Film()
    var body: some View {
        VStack {
            HStack {
                Text("Please Rate Quality Of The Movie").fontWeight(.bold).foregroundColor(.white)
                Spacer()
            }.padding()
                .background(Color.orange)
            VStack {
                if self.rate != 0 {
                    if self.rate == 5 {
                        Text("Excellent").fontWeight(.bold).foregroundColor(.orange)
                    } else if self.rate == 4 {
                        Text("Good").fontWeight(.bold).foregroundColor(.orange)
                    } else {
                        Text("Okay").fontWeight(.bold).foregroundColor(.orange)
                    }
                }
            }.padding(.top, 20)
            HStack(spacing: 15) {
                ForEach(1...5,id: \.self) { i in
                    Button (action: {
                        self.rate = i
                    }) {
                        Image(systemName: self.rate == 0 ?  "star": "star.fill" ).resizable().frame(width: 25, height: 25).foregroundColor(i <= self.rate ? .orange : .gray)
                    }
                }
            }.padding()
            HStack {
                Spacer()
                Button(action: {
                    self.rate = 0
                    self.show.toggle()
                }) {
                    Text("Cancel")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                }
                
                Button(action: {
                    updateRate(film: self.film, rate: self.rate)
                    self.show.toggle()
                }) {
                    Text("Submit")
                        .foregroundColor(self.rate != 0 ? Color.orange : Color.black.opacity(0.2))
                        .fontWeight(.bold)
                }.padding(.leading, 20)
                    .disabled(self.rate == 0)
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

