//
//  CinemaService.swift
//  Cinema
//
//  Created by MacBook Pro on 4/3/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

class CinemaService : ObservableObject {
    @Published var dataFilms = [Film]()
    @Published var dataFood = [Food]()
    init() {
        getData()
        getFood()
    }
    func getFood() {
        Firestore.firestore().collection("Food").addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            snap?.documentChanges.forEach({ (doc) in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let name = doc.document.get("name") as! String
                    let price = doc.document.get("price") as! Int
                    let image = doc.document.get("image") as! String
                    self.dataFood.append(Food(id: id, name: name, image: image, price: price, count: 0))
                }
                if doc.type == .modified {
                    self.dataFood = self.dataFood.map({ (food) -> Food in
                        if food.id == doc.document.documentID {
                            var result = food
                            result.name = doc.document.get("name") as! String
                            result.price = doc.document.get("price") as! Int
                            result.image = doc.document.get("image") as! String
                            return result
                        } else {
                            return food
                        }
                    })
                }
                if doc.type == .removed {
                    self.dataFood = self.dataFood.filter({ (Food) -> Bool in
                        return Food.id != doc.document.documentID
                    })
                }
            })
        }
    }
    func getData() {
        Firestore.firestore().collection("Movie").addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            snap?.documentChanges.forEach({ (doc) in
                if doc.type == .added {
                    
                    let id = doc.document.documentID
                    let name = doc.document.get("name") as! String
                    let image = doc.document.get("image") as! String
                    let stampStart = doc.document.get("time") as! String
                    let info = doc.document.get("info") as! String
                    let category = doc.document.get("genre") as! [String]
                    let rate = doc.document.get("rate") as! [Int]
                    let movieDay = doc.document.get("movieDay") as! [Timestamp]
                    
                    let days = movieDay.map { (item) -> Date in
                        return item.dateValue()
                    }
                    
                    self.dataFilms.append(Film(id:id,name:name,image:image,time:stampStart,info: info,rate: rate,movieDay: days,category: category))
                }
                if doc.type == .modified {
                    
                    self.dataFilms = self.dataFilms.map({ (film) -> Film in
                        if film.id == doc.document.documentID {
                            var result = film
                            
                            result.name = doc.document.get("name") as! String
                            result.image = doc.document.get("image") as! String
                            result.time = doc.document.get("time") as! String
                            result.info = doc.document.get("info") as! String
                            result.rate = doc.document.get("rate") as! [Int]
                            result.category = doc.document.get("genre") as! [String]
                            
                            let movieDay = doc.document.get("movieDay") as! [Timestamp]
                            
                            result.movieDay = movieDay.map { (item) -> Date in
                                return item.dateValue()
                            }
                            
                            
                            return result
                        } else {
                            return film
                        }
                    })
                }
                if doc.type == .removed {
                    self.dataFilms = self.dataFilms.filter({ (Film) -> Bool in
                        return Film.id != doc.document.documentID
                    })
                }
            })
            
        }
    }
}
var dataMennuBars = ["Home","Orders","Activity","Admin","Search","Help"]
var dataGenres = ["Action & Adventure","Animation","Comedy","Crime","Drama","Science Fiction & Fantasy","Historical","Horror","Romance"]
func splitArray(arr:[Film]) -> [type] {
    var temp = arr
    var result = [type]()
    if arr.count > 0 {
        while temp.count > 0 {
            let newArray = Array(temp.prefix(3))
            temp = Array(temp.dropFirst(3))
            result.append(type(id: result.count+1, row: newArray))
        }
    }
    return result
}
func betweenTime(time1:Date,time2:Date) -> String {
    let diff = Int(time1.timeIntervalSince1970 - time2.timeIntervalSince1970)
    let hours = diff/3600
    let minute = (diff - hours * 3600) / 60
    return "\(hours)h \(minute)m"
}
func avgRate(arr : [Int]) -> Double {
    
    return Double(arr.reduce(0) { (Result, element) -> Int in
        return Result + element
    } ) / Double(arr.count)
}
func fomartDaytoDate(date:Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter.string(from: date)
}
func fomartTimetoDate(date:Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    return formatter.string(from: date)
}
func sortDates(dates: [Date]) -> [Date] {
    return dates.sorted {
        $0 < $1
    }
}
func updateRate(film:Film,rate:Int) {
    var temp = film.rate
    temp.append(rate)
    Firestore.firestore()
        .collection("Movie")
        .document(film.id)
        .updateData(["rate":temp])
}
func addActivity(film: Film) {
    Firestore.firestore().collection("Activity").document().setData(["name" : film.name,"image": film.image,"uid":(Auth.auth().currentUser?.uid)!])
}
func removeActivity(id: String) {
    Firestore.firestore().collection("Activity").document(id).delete()
}
func addTickets(film: Film,seats: [Seat],foods: [Food],date: Date,totalMoney: Int) {
    var ref: DocumentReference? = nil
    ref = Firestore.firestore().collection("Order").addDocument(data: ["uid": Auth.auth().currentUser!.uid,"name": film.name, "date": date, "image":film.image,"total": totalMoney]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            seats.forEach { (Seat) in
                Firestore.firestore().collection("Order").document(ref!.documentID).collection("Ticket").document().setData(["colum": Seat.colum, "row": Seat.row])
            }
            
            foods.forEach { (Food) in
                Firestore.firestore().collection("Order").document(ref!.documentID).collection("Food").document().setData(["name": Food.name,"price": Food.price,"image":Food.image, "count": Food.count])
            }
        }
    }
    
}
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
func addMovie(name : String, info : String, time : String,genre : [String],dates : [Date],imageData: Data,completion: @escaping (Bool)-> Void) {
    let storage = Storage.storage().reference()
    let id = randomString(length: 20)
    storage.child("Films").child(id).putData(imageData, metadata: nil) { (_, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        storage.child("Films").child(id).downloadURL { (url, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            Firestore.firestore().collection("Movie").document().setData(["name":name,"image": "\(url!)","time":time,"info":info,"genre":genre,"movieDay":dates,"rate":[Int]()])
            completion(true)
        }
    }
}
func updateMovie(film : Film,imageData: Data,completion: @escaping (Bool)-> Void) {
    if imageData.count == 0 {
        Firestore.firestore()
            .collection("Movie")
            .document(film.id)
            .updateData(["name":film.name,"image": film.image,"time":film.time,"info":film.info,"genre":film.category,"movieDay":film.movieDay,"rate":film.rate])
        completion(true)
    } else {
        let storage = Storage.storage().reference()
        let id = randomString(length: 20)
        storage.child("Films").child(id).putData(imageData, metadata: nil) { (_, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            storage.child("Films").child(id).downloadURL { (url, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                Firestore.firestore()
                    .collection("Movie")
                    .document(film.id)
                    .updateData(["name":film.name,"image": "\(url!)","time":film.time,"info":film.info,"genre":film.category,"movieDay":film.movieDay,"rate":film.rate])
                completion(true)
            }
        }
    }
}
func deleteFilm(id: String) {
    Firestore.firestore().collection("Movie").document(id).delete()
}
func addFood(food : Food,imageData: Data,completion: @escaping (Bool)-> Void) {
    let storage = Storage.storage().reference()
    let id = randomString(length: 20)
    storage.child("Food").child(id).putData(imageData, metadata: nil) { (_, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        storage.child("Food").child(id).downloadURL { (url, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            Firestore.firestore()
                .collection("Food")
                .document()
                .setData(["name":food.name,"price":food.price,"image":"\(url!)"])
            completion(true)
        }
    }
}
func updateFood(food: Food,imageData: Data,completion: @escaping (Bool)-> Void) {
    if imageData.count == 0 {
        Firestore.firestore()
            .collection("Food")
            .document(food.id)
            .updateData(["name":food.name,"price": food.price,"image": food.image])
        completion(true)
    } else {
        let storage = Storage.storage().reference()
        let id = randomString(length: 20)
        storage.child("Films").child(id).putData(imageData, metadata: nil) { (_, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            storage.child("Films").child(id).downloadURL { (url, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                Firestore.firestore()
                    .collection("Movie")
                    .document(food.id)
                    .updateData(["name":food.name,"price": food.price,"image": "\(url!)"])
                completion(true)
            }
        }
    }
}
func deleteFood(id: String) {
    Firestore.firestore().collection("Food").document(id).delete()
}
