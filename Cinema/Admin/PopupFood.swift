//
//  PopupFood.swift
//  Cinema
//
//  Created by MacBook Pro on 4/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopupFood: View {
    @Binding var show : Bool
    @State var food  = Food()
    @State var imageData : Data = .init(count: 0)
    @State var picker : Bool = false
    @State var isLoading : Bool = false
    func checkForm() -> Bool {
        return !food.name.isEmpty || food.price != 0
    }
    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                    Button(action: {
                        self.picker.toggle()
                    }) {
                        if self.imageData.count == 0 {
                                AnimatedImage(url: URL(string: self.food.image))
                                .resizable()
                                .frame(width: 300, height: 300)
                                .clipShape(Circle())
                        } else {
                            Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 300, height: 300).clipShape(Circle())
                        }
                    }
                    Spacer()
                }.padding()
                TextField("Name", text: self.$food.name)
                          .padding()
                          .background(Color("Color"))
                          .clipShape(RoundedRectangle(cornerRadius: 10))
                TextField("Price",value: self.$food.price, formatter: NumberFormatter())
                          .padding()
                          .background(Color("Color"))
                          .clipShape(RoundedRectangle(cornerRadius: 10))
                    if self.isLoading {
                        HStack {
                            Spacer()
                            Indicator()
                            Spacer()
                        }
                    } else {
                        VStack(spacing : 0) {
                            Button(action: {
                                if self.checkForm() {
                                    self.isLoading.toggle()
                                    updateFood(food: self.food, imageData: self.imageData) { (Bool) in
                                        if Bool {
                                            self.isLoading.toggle()
                                            self.show.toggle()
                                        }
                                    }
                                }
                            }) {
                                Text("Update Food")
                                    .padding()
                                    .foregroundColor(.white)
                            }.disabled(!(self.checkForm()))
                            Rectangle().frame(height: 5)
                                .foregroundColor(self.checkForm() ? .orange : .gray)
                        }.background(self.checkForm() ? Color.orange.opacity(0.6):Color.black.opacity(0.7))
                        .cornerRadius(10)
                    }
                }
        }.padding()
        }
}

