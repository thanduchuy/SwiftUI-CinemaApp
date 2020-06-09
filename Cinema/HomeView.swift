//
//  HomeView.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    @EnvironmentObject var cinema : CinemaService
    @State private var showingActionSheet = false
    @State private var category = "All Movies In Cinema"
    var buttonsArray: NSMutableArray = NSMutableArray()
    func createCategory() -> [String] {
        return self.cinema.dataFilms.reduce([String]()) { (Result, item) -> [String] in
            var temp = Result
            item.category.forEach { (element) in
                if !temp.contains(element.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    temp.append(element)
                }
            }
            return temp
        }
    }
    func showMovie() -> Binding<[Film]>{
        let result = self.cinema.dataFilms
        if category == "All Movies In Cinema" {
            return Binding<[Film]>.constant(result)
        } else {
            return Binding<[Film]>.constant(result.filter { (Film) -> Bool in
                return Film.category.contains(self.category)
            })
        }
    }
    func loadArray(arr: [String]) -> Bool{
        self.buttonsArray.removeAllObjects()
        let buttonFirst: ActionSheet.Button = .default(Text("All Movies In Cinema"),action : {
            self.category = "All Movies In Cinema"
        })
        self.buttonsArray.add(buttonFirst)
        for i in 0 ..< arr.count {
            let button: ActionSheet.Button = .default(Text(arr[i]),action : {
                          self.category = arr[i]
                      })
                      self.buttonsArray.add(button)
        }
        return true
    }
    var body: some View {
        VStack(spacing:15) {
            if loadArray(arr: createCategory()) {
                HStack {
                    VStack (alignment: .leading, spacing: 15) {
                        
                        Text("Home").font(.largeTitle)
                        
                        Button(action: {
                            self.showingActionSheet = true
                        }) {
                            HStack(spacing: 8) {
                                Text(category)
                                Image(systemName: "chevron.down").font(.body)
                            }
                        }.foregroundColor(.black)
                        
                    }
                    Spacer()
                    Image("film").resizable().frame(width: 50, height: 50)
                    
                }
            }
            itemFilm(film: showMovie(),foods: self.$cinema.dataFood)
        }.padding()
        .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change Category"), message: Text("Choose the movie genre you want"), buttons: self.buttonsArray as! [ActionSheet.Button])
        }
    }
}

