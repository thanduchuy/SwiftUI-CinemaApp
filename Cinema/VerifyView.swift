//
//  VerifyView.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct VerifyView: View {
    @State var code  = ""
    @Binding var show : Bool
    @Binding var ID : String
    @State var msg  = ""
    @State var alert = false
    @State var isShow = false
    @State var loading = false
    var body: some View {
        ZStack (alignment: .topLeading) {
            GeometryReader { _ in
                VStack (spacing:20) {
                    Image("cinema")
                    Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy)
                    
                    Text("Please Enter Your Number To Verify Your Account")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 12)
                    TextField("Code", text: self.$code)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 15)
                    if self.loading {
                        HStack {
                            Spacer()
                            Indicator()
                            Spacer()
                        }
                    } else {
                        Button(action: {
                            self.loading.toggle()
                            let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                            Auth.auth().signIn(with: credential) { (res, err) in
                                if err != nil {
                                    self.msg = (err?.localizedDescription)!
                                    self.alert.toggle()
                                    self.loading.toggle()
                                    return
                                }
                                checkUser { (exists, user) in
                                    if exists {
                                        UserDefaults.standard.set(true, forKey: "status")
                                        UserDefaults.standard.set(user, forKey: "user")
                                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                    } else {
                                        self.loading.toggle()
                                        self.isShow.toggle()
                                    }
                                }
                            }
                        }) {
                            Text("Verify").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        }.foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                }
            }
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "chevron.left").font(.title)
            }.foregroundColor(.orange)
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented:  self.$isShow) {
            AccountCreation(show: self.$isShow)
        }
    }
}
