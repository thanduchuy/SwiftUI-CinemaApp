//
//  itemFilm.swift
//  Cinema
//
//  Created by MacBook Pro on 4/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct itemFilm: View {
    @Binding var film : [Film]
    @State var isShow : Bool = false
    @State var picker : Film = Film()
    @Binding var foods : [Food]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                 Text("There are \(self.film.count) movies in theaters now")
                Spacer()
            }
            VStack(spacing:15) {
                ForEach(splitArray(arr: self.film)) { item in
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing:15) {
                            ForEach(item.row) { element in
                                VStack(alignment: .leading, spacing: 12) {
                                    AnimatedImage(url: URL(string: element.image)!).resizable().frame(width: 170, height: 220).cornerRadius(10).onTapGesture {
                                        self.picker = element
                                        self.isShow.toggle()
                                    }
                                    Text(element.name).font(.caption)
                                    Text(element.time).font(.caption)
                                }.foregroundColor(Color.black.opacity(0.5))
                            }
                        }
                    }
                }
            }
        }.sheet(isPresented: $isShow) {
            Detail(film: self.picker,foods: self.foods,isShow: self.$isShow)
                .environmentObject(HistoryService()).environmentObject(ActivitySevice())
        }
    }
}

