//
//  CreateFood.swift
//  Cinema
//
//  Created by MacBook Pro on 4/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct CreateFood: View {
    @Binding var showCreate : Bool
    @State var name = ""
    @State var price = ""
    @State var imageData : Data = .init(count: 0)
    @State var picker : Bool = false
    @State var isLoading : Bool = false
    func checkForm() -> Bool {
        return !name.isEmpty && !price.isEmpty && self.imageData.count != 0
    }
    func resetForm() {
        self.name = ""
        self.price = ""
        self.imageData == .init(count: 0)
    }
    var body: some View {
        VStack(spacing : 20) {
            Text("Create Food")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.orange)
            HStack {
                Spacer()
                Button(action: {
                    self.picker.toggle()
                }) {
                    if self.imageData.count == 0 {
                        Image("createFood").resizable().renderingMode(.original).frame(width: 200, height: 200)
                    } else {
                        Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 200, height: 200).clipShape(Circle())
                    }
                }
                Spacer()
            }.padding()
            
            TextField("Name Food ...", text: $name)
                .frame(width: UIScreen.main.bounds.width-60)
                .padding()
                .border(Color.orange, width: 1)
            TextField("Price Food ...", text: $price)
                .frame(width: 150)
                .padding()
                .border(Color.orange, width: 1)
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
                            addFood(food: Food(name:self.name,price: Int(self.price)!), imageData: self.imageData) { (Bool) in
                                if Bool {
                                    self.isLoading.toggle()
                                    self.resetForm()
                                    self.showCreate.toggle()
                                }
                            }
                        }
                    }) {
                        Text("Create Food")
                            .padding()
                            .foregroundColor(.white)
                    }.disabled(!(self.checkForm()))
                    Rectangle().frame(height: 5)
                        .foregroundColor(self.checkForm() ? .orange : .gray)
                }.background(self.checkForm() ? Color.orange.opacity(0.6):Color.black.opacity(0.7))
                .cornerRadius(10)
            }
            
        }.padding()
        .sheet(isPresented: self.$picker, content: {
            imagePicker(picker: self.$picker, imageData: self.$imageData)
        })
    }
}
