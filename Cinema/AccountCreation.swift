//
//  AccountCreation.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AccountCreation: View {
    @Binding var show : Bool
    @State var name : String = ""
    @State var email : String = ""
    @State var picker : Bool = false
    @State var loading : Bool = false
    @State var imageData : Data = .init(count: 0)
    @State var alert : Bool = false
    var body: some View {
        VStack (alignment: .leading, spacing: 15) {
            Text("Awesome !!! Create An Account").font(.title)
            HStack {
                Spacer()
                Button(action: {
                    self.picker.toggle()
                }) {
                    if self.imageData.count == 0 {
                        Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width: 90, height: 70).foregroundColor(.gray)
                    } else {
                        Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 90, height: 90).clipShape(Circle())
                    }
                }
                Spacer()
            }.padding(.vertical, 15)
            Text("Enter Email")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            TextField("Email...", text: $email)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text("Enter Name")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            TextField("Name...", text: $name)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            if self.loading {
                HStack {
                    Spacer()
                    Indicator()
                    Spacer()
                }
            } else {
                Button(action: {
                    if !self.name.isEmpty && !self.email.isEmpty && self.imageData.count != 0 {
                        self.loading.toggle()
                        createUser(name: self.name, email: self.email, imageData: self.imageData) { (err) in
                            if err {
                                self.show.toggle()
                            }
                        }
                    } else {
                        self.alert.toggle()
                    }
                }) {
                    Text("Create").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }.foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            imagePicker(picker: self.$picker, imageData: self.$imageData)
        })
            .alert(isPresented: self.$alert) {
                Alert(title: Text("Error"), message: Text("Please Fill The Contents"), dismissButton: .default(Text("OK")))
        }
    }
}

