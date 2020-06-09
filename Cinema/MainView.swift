//
//  MainView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Binding var show : Bool
    @Binding var index : String
    var body: some View {
        VStack(spacing : 0) {
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            self.show.toggle()
                        }
                    }) {
                        Image(systemName: "list.dash")
                            .resizable()
                            .frame(width: 20, height: 15)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "increase.quotelevel")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.black)
                    }
                }
                Text("Cinema").fontWeight(.bold).font(.title)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            ZStack {
                HomeView().opacity(self.index == "Home" ? 1 : 0)
                ActivityView().opacity(self.index == "Activity" ? 1 : 0)
                OrderView().opacity(self.index == "Orders" ? 1 : 0)
                AdminView().opacity(self.index == "Admin" ? 1 : 0)
                Search().opacity(self.index == "Search" ? 1 : 0)
                HelpView().opacity(self.index == "Help" ? 1 : 0)
            }
        }.background(Color.white)
        .cornerRadius(15)
    }
}

