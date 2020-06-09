//
//  LoginView.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct LoginView: View {
    @State var number : String = ""
    @State var ccode  = ""
    @State var show = false
    @State var msg  = ""
    @State var alert = false
    @State var ID = ""
    var body: some View {
        VStack (spacing:20) {
            Image("cinema")
            Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy)
            
            Text("Please Enter Your Number To Verify Your Account")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            
            HStack{
                
                TextField("+1", text: $ccode)
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
                TextField("Number", text: $number)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } .padding(.top, 15)
            NavigationLink(destination: VerifyView(show: $show, ID: $ID), isActive: $show) {
                Button(action: {
                    Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.number, uiDelegate: nil) { (ID, err) in
                        if err != nil {
                            self.msg = (err?.localizedDescription)!
                            self.alert.toggle()
                            return
                        }
                        self.ID = ID!
                        self.show.toggle()
                    }
                }) {
                    Text("Send").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }.foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
    }
}
