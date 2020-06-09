//
//  SearchView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var txt : String = ""
    @State var select = Film()
    @State var isShow : Bool = false
    @EnvironmentObject var cinema : CinemaService
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass").font(.body)
                    TextField("Search Movies", text: $txt)
                }.padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(30)
                if !self.txt.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.txt = ""
                        }) {
                            Image(systemName: "trash.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }.foregroundColor(.black)
                    }.padding()
                }
            }
            if !self.txt.isEmpty {
                List(self.cinema.dataFilms.filter{$0.name.lowercased().contains(self.txt.lowercased())}) { i in
                    Text(i.name).onTapGesture {
                        self.select = i
                        self.isShow.toggle()
                    }
                }.frame( height: 500)
            }
            Spacer()
        }.padding()
        .sheet(isPresented: self.$isShow) {
            Detail(film: self.select, foods: self.cinema.dataFood, isShow: self.$isShow)
                .environmentObject(HistoryService())
        }
    }
}

