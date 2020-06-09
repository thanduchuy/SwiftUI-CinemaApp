//
//  UpdatePopup.swift
//  Cinema
//
//  Created by MacBook Pro on 4/14/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct UpdatePopup: View {
    @State var film = Film()
     @Binding var showPopup : Bool
    @State var showGenres = false
    @State var selectGenres = 0
    @State var dateSelected = Date()
    @State var indexDate = 0
    @State var imageData : Data = .init(count: 0)
    @State var picker : Bool = false
    @State var loading : Bool = false
    let maxDate = Calendar.current.date(byAdding: .day,value: 20 , to: Date())!
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                    Button(action: {
                        self.picker.toggle()
                    }) {
                        if self.imageData.count == 0 {
                                AnimatedImage(url: URL(string: self.film.image))
                                .resizable()
                                .frame(width: 300, height: 300)
                                .clipShape(Circle())
                        } else {
                            Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 300, height: 300).clipShape(Circle())
                        }
                    }
                    Spacer()
                }.padding()
                TextField("Name", text: self.$film.name)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                TextField("Time", text: self.$film.time)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Mutiline(text: self.$film.info)
                    .frame(height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.orange, lineWidth: 1)
                            .shadow(color: .orange, radius: 10, x: 2, y: 2)
                )
                HStack {
                    
                    HStack {
                        VStack(spacing : 5) {
                            HStack {
                                Text("Picker Genre")
                                    .fontWeight(.bold)
                                
                                Image(systemName: self.showGenres ? "chevron.up":"chevron.down")
                                    .resizable()
                                    .frame(width: 13, height: 6)
                            }.foregroundColor(.white)
                                .onTapGesture {
                                    if self.showGenres {
                                        self.showGenres.toggle()
                                    }
                            }
                            if showGenres {
                                ForEach(dataGenres , id: \.self) { i in
                                    Button(action: {
                                        self.film.category[self.selectGenres] = i
                                        self.showGenres.toggle()
                                    }) {
                                        Text(i).padding()
                                    }.foregroundColor(.white)
                                }
                            }
                        }.padding()
                            .background(LinearGradient(gradient: .init(colors: [Color("Color"),.orange]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(15)
                            .shadow(color: .gray, radius: 5)
                            .animation(.spring())
                        Spacer()
                        
                    }.padding()
                    Spacer()
                    VStack {
                        ForEach(0..<self.film.category.count, id: \.self) { item in
                            HStack(spacing: 0) {
                                Text(self.film.category[item]).font(.subheadline)
                                Spacer()
                                Image(systemName: "trash.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        self.film.category.remove(at: item)
                                }
                            }.padding()
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .cornerRadius(5)
                                .onTapGesture {
                                    self.showGenres.toggle()
                                    self.selectGenres = item
                            }
                        }
                    }.padding()
                }
                VStack(spacing : 10) {
                    DatePicker("", selection: self.$dateSelected,in: Date()...maxDate)
                        .labelsHidden()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<self.film.movieDay.count, id : \.self) { index in
                                VStack(alignment : .center) {
                                    Text(fomartDaytoDate(date:  self.film.movieDay[index]))
                                    Text(fomartTimetoDate(date:  self.film.movieDay[index]))
                                    Button(action: {
                                        self.film.movieDay.remove(at: index)
                                    }) {
                                        Image(systemName: "bin.xmark.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                    }.padding()
                                        .foregroundColor(.orange)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }.padding()
                                    .foregroundColor(.white)
                                    .background(Color.orange.opacity(0.8))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        self.dateSelected = self.film.movieDay[index]
                                        self.indexDate = index
                                }
                            }
                        }
                    }
                    Button(action: {
                        self.film.movieDay[self.indexDate] = self.dateSelected
                        self.dateSelected = Date()
                    }) {
                        Text("Update Movie Day").foregroundColor(.white).padding()
                    }.frame(maxWidth : .infinity)
                        .background(self.dateSelected != Date() ? Color.black.opacity(0.7):Color.orange.opacity(0.6))
                        .cornerRadius(500)
                        .shadow(color: .orange, radius: 10, x: 2, y: 2)
                        .disabled(self.dateSelected != Date())
                    
                    if self.loading {
                                   HStack {
                                       Spacer()
                                       Indicator()
                                       Spacer()
                                   }
                               } else {
                        Button(action: {
                            if !self.film.name.isEmpty && !self.film.time.isEmpty && !self.film.info.isEmpty {
                                self.loading.toggle()
                                updateMovie(film: self.film, imageData: self.imageData) { (Bool) in
                                    if Bool {
                                        self.loading.toggle()
                                        self.showPopup.toggle()
                                    }
                                }
                            }
                        }) {
                             Text("Update").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        }.foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(10)
                    }
                }.padding()
            }
            
        }.padding()
        .sheet(isPresented: self.$picker, content: {
            imagePicker(picker: self.$picker, imageData: self.$imageData)
        })
    }
}

