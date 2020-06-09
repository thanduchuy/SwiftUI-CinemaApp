//
//  ContentView.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @EnvironmentObject var auth : AuthServices
    
    @State var index = "Home"
    @State var show = false
    
    var body: some View {
        VStack {
            if status {
                ZStack {
                    (self.show ? Color.black.opacity(0.05):Color.clear).edgesIgnoringSafeArea(.all)
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 25) {
                            HStack(spacing:15) {
                                AnimatedImage(url:URL(string: auth.user.avatar))
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(auth.user.name).fontWeight(.bold)
                                    Text(auth.user.email)
                                }
                            }.padding(.bottom, 50)
                            ForEach(dataMennuBars,id: \.self) { item in
                                Button(action: {
                                    self.index = item
                                    withAnimation(.spring()) {
                                        self.show.toggle()
                                    }
                                }) {
                                    HStack {
                                        Capsule()
                                            .fill(self.index == item ? Color.orange : Color.clear)
                                            .frame(width: 5, height: 20)
                                        Text(item).padding(.leading)
                                    }.padding(.vertical)
                                }
                            }
                            Spacer()
                        }.padding(.leading)
                            .padding(.top)
                            .scaleEffect(self.show ? 1 : 0.001)
                        ZStack (alignment: .topTrailing){
                            MainView(show: self.$show, index: self.$index)
                                .scaleEffect(self.show ? 0.8 : 1)
                                .offset(x:self.show ? 150 : 0,y: self.show ? 50 : 0)
                                .disabled(self.show)
                            Button(action: {
                                withAnimation(.spring()) {
                                    self.show.toggle()
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                            }.padding()
                                .opacity(self.show ? 1 : 0)
                        }
                    }
                }
            } else {
                NavigationView {
                    LoginView()
                }
            }
            
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
