//
//  CreateFilm.swift
//  Cinema
//
//  Created by MacBook Pro on 4/12/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct  CreateFilm : View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showCreate : Bool
    @State var imageData : Data = .init(count: 0)
    @State var picker : Bool = false
    @State var info : String = ""
    @State var name : String = ""
    @State var time : String = ""
    @State var openGenre = false
    @State var genres = [String]()
    @State var dates = [Date]()
    @State var dateSelected : Date = Date()
    @State var isLoading =  false
    let maxDate = Calendar.current.date(byAdding: .day,value: 20 , to: Date())!
    func checkForm() -> Bool {
        return self.imageData.count != 0 && !name.isEmpty && !info.isEmpty && !time.isEmpty && genres.count != 0 && dates.count != 0
    }
    func clearForm() {
        self.imageData = .init(count: 0)
        self.name = ""
        self.info = ""
        self.time = ""
        self.genres = [String]()
        self.dates = [Date]()
    }
    var body : some View {
       NavigationView {
                  ScrollView(.vertical, showsIndicators: false) {
                      ZStack (alignment: .top) {
                          VStack(alignment : .leading,spacing: 10) {
                              HStack {
                                  Spacer()
                                  Button(action: {
                                      self.picker.toggle()
                                  }) {
                                      if self.imageData.count == 0 {
                                          Image("create").resizable().renderingMode(.original).frame(width: 200, height: 200)
                                      } else {
                                          Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 200, height: 200).clipShape(Circle())
                                      }
                                  }
                                  Spacer()
                              }.padding()
                              
                              TextField("Name Cinema ...", text: $name)
                                  .frame(width: UIScreen.main.bounds.width-60)
                                  .padding()
                                  .border(Color.orange, width: 1)
                              TextField("Time Cinema ...", text: $time)
                                  .frame(width: 150)
                                  .padding()
                                  .border(Color.orange, width: 1)
                              
                              multilineTextFiel(txt: self.$info)
                                  .frame(height: 300)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 5)
                                          .stroke(Color.orange, lineWidth: 1)
                                          .shadow(color: .orange, radius: 10, x: 2, y: 2)
                              )
                              HStack {
                                  Spacer(minLength: 170)
                                  VStack {
                                      ForEach(0..<self.genres.count, id: \.self) { item in
                                          HStack(spacing: 0) {
                                              Text(self.genres[item]).font(.subheadline)
                                              Spacer()
                                              Image(systemName: "trash.circle.fill")
                                                  .resizable()
                                                  .frame(width: 20, height: 20)
                                                  .onTapGesture {
                                                      self.genres.remove(at: item)
                                              }
                                          }.padding()
                                              .foregroundColor(.white)
                                              .background(Color.orange)
                                              .cornerRadius(5)
                                      }
                                  }.padding()
                              }
                              VStack(spacing : 10) {
                                  DatePicker("", selection: self.$dateSelected,in: Date()...maxDate)
                                      .labelsHidden()
                                  ScrollView(.horizontal, showsIndicators: false) {
                                      HStack {
                                          ForEach(0..<self.dates.count, id : \.self) { index in
                                              VStack(alignment : .center) {
                                                  Text(fomartDaytoDate(date: self.dates[index]))
                                                  Text(fomartTimetoDate(date: self.dates[index]))
                                                  Button(action: {
                                                      self.dates.remove(at: index)
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
                                          }
                                      }
                                  }
                                  Button(action: {
                                      self.dates.append(self.dateSelected)
                                      self.dateSelected = Date()
                                  }) {
                                      Text("Add Movie Day").foregroundColor(.white).padding()
                                  }.frame(maxWidth : .infinity)
                                      .background(Color.orange.opacity(0.6))
                                      .cornerRadius(500)
                                      .shadow(color: .orange, radius: 10, x: 2, y: 2)
                              }
                              .padding(.top, 20)
                              .padding()
                              
                              VStack {
                                  if isLoading {
                                      HStack {
                                          Spacer()
                                          Indicator()
                                          Spacer()
                                      }
                                  } else {
                                      Button(action: {
                                          if self.checkForm() {
                                              self.isLoading.toggle()
                                              addMovie(name: self.name, info: self.info, time: self.time, genre: self.genres, dates: self.dates, imageData: self.imageData) { (Bool) in
                                                  if Bool {
                                                      self.isLoading.toggle()
                                                      self.clearForm()
                                                      self.showCreate.toggle()
                                                  }
                                              }
                                          }
                                      }) {
                                          Text("Add Movie").foregroundColor(.white).padding()
                                      }.frame(maxWidth : .infinity)
                                          .background(checkForm() ? Color.orange.opacity(0.7) : Color.black.opacity(0.7))
                                          .cornerRadius(10)
                                          .shadow(color: .orange, radius: 10, x: 2, y: 2)
                                          .disabled(!(self.checkForm()))
                                  }
                              }.padding()
                          }.padding()
                          HStack {
                              VStack(spacing : 5) {
                                  HStack {
                                      Text("Picker Genre")
                                          .fontWeight(.bold)
                                      
                                      Image(systemName: self.openGenre ? "chevron.up":"chevron.down")
                                          .resizable()
                                          .frame(width: 13, height: 6)
                                  }.foregroundColor(.white)
                                      .onTapGesture {
                                          self.openGenre.toggle()
                                  }
                                  if openGenre {
                                      ForEach(dataGenres , id: \.self) { i in
                                          Button(action: {
                                              self.genres.append(i)
                                              self.openGenre.toggle()
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
                              .padding(.top,700)
                      }
                  }.padding(.vertical,15)
                      .edgesIgnoringSafeArea([.top, .bottom])
                      .sheet(isPresented: self.$picker, content: {
                          imagePicker(picker: self.$picker, imageData: self.$imageData)
                      })
              }
    }
}
