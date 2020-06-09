//
//  DeleteFood.swift
//  Cinema
//
//  Created by MacBook Pro on 4/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct DeleteFood: View {
    @Binding var showDelete : Bool
    @EnvironmentObject var cinema : CinemaService
    var body: some View {
         ScrollView(.vertical, showsIndicators: false) {
                       VStack(alignment: .leading,spacing : 10) {
                           ForEach(self.cinema.dataFood) { item in
                               HStack {
                                   AnimatedImage(url: URL(string: item.image))
                                       .resizable()
                                       .frame(width: 100, height: 100)
                                       .clipShape(Circle())
                                   Spacer()
                                   Text(item.name)
                                       .foregroundColor(.white)
                                   Spacer()
                                   Button(action: {
                                       deleteFood(id: item.id)
                                       self.showDelete.toggle()
                                   }) {
                                       Image(systemName: "trash")
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                           .padding()
                                           .background(Color.white)
                                           .clipShape(Circle())
                                   }
                               }
                               .background(Color.orange)
                               .cornerRadius(50)
                           }
                       }
                   }
    }
}

