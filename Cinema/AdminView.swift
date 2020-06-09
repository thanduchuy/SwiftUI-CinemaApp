//
//  AdminView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var cinema : CinemaService
    @State var showCreate = false
    @State var showUpdate = false
    @State var showDelete = false
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    Image("admin")
                        .resizable()
                        .frame(width: 50,height: 50)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Admin")
                        Text("admin@cinema.com")
                    }
                    Spacer()
                }
                HStack(spacing: 15) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Films").fontWeight(.bold)
                            
                            Text("\(self.cinema.dataFilms.count)")
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                        }
                        Spacer()
                    }.padding()
                        .frame(width: (UIScreen.main.bounds.width-90)/2)
                        .background(Color.blue)
                        .cornerRadius(15)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Foods").fontWeight(.bold)
                            
                            Text("\(self.cinema.dataFood.count)")
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                        }
                        Spacer()
                    }.padding()
                        .frame(width: (UIScreen.main.bounds.width-90)/2)
                        .background(Color.pink)
                        .cornerRadius(15)
                }
                .foregroundColor(.white)
                .padding(.top)
                NavigationLink(destination: AdminCreate(showCreate: self.$showCreate),isActive: $showCreate) {
                    HStack(spacing: 15) {
                        Image(systemName: "tray.and.arrow.up.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Create")
                        Spacer()
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color("Color"))
                }.cornerRadius(15)
                NavigationLink(destination: AdminUpdate(showUpdate: self.$showUpdate), isActive: $showUpdate) {
                    HStack(spacing: 15) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Update")
                        Spacer()
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color("Color"))
                }.cornerRadius(15)
                NavigationLink(destination: AdminDelete(showDelete: self.$showDelete), isActive: self.$showDelete) {
                    HStack(spacing: 15) {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Delete")
                        Spacer()
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }.padding()
                        .foregroundColor(.black)
                        .background(Color("Color"))
                }.cornerRadius(15)
                Spacer()
            }.padding()
                .padding(.top)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
