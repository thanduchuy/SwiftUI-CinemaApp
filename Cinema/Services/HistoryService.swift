//
//  HistoryService.swift
//  Cinema
//
//  Created by MacBook Pro on 4/9/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

class HistoryService: ObservableObject {
    @Published var data  = [Seat]()
    @Published var orders  = [Order]()
    init() {
        Firestore.firestore().collection("Order").whereField("uid", isEqualTo: (Auth.auth().currentUser?.uid)!).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            snap?.documentChanges.forEach({ (doc) in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let name = doc.document.get("name") as! String
                    let uid = doc.document.get("uid") as! String
                    let image = doc.document.get("image") as! String
                    let date = doc.document.get("date") as! Timestamp
                    let total = doc.document.get("total") as! Int
                    var foods = [Food]()
                    var seats = [Seat]()
                    
                    Firestore.firestore().collection("Order").document(id).collection("Food").getDocuments { (snap, err) in
                        if err != nil {
                            print((err?.localizedDescription)!)
                            return
                        }
                        snap?.documents.forEach({ (doc) in
                            let id = doc.documentID
                            let count = doc.data()["count"] as! Int
                            let price = doc.data()["price"] as! Int
                            let name = doc.data()["name"] as! String
                            let image = doc.data()["image"] as! String
                            
                            foods.append(Food(id: id, name: name, image: image, price: price, count: count))
                        })
                        Firestore.firestore().collection("Order").document(id).collection("Ticket").getDocuments { (snap, err) in
                            if err != nil {
                                print((err?.localizedDescription)!)
                                return
                            }
                            snap?.documents.forEach({ (doc) in
                                let id = doc.documentID
                                let row = doc.data()["row"] as! Int
                                let colum = doc.data()["colum"] as! Int
                                
                                seats.append(Seat(id: id, colum: colum, row: row))
                            })
                            
                            self.orders.append(Order(id: id, name: name, image: image, uid: uid,total: total, date: date.dateValue(), foods: foods, seats: seats))
                        }
                    }
                }
                if doc.type == .modified {
                    self.orders = self.orders.map({ (item) -> Order in
                        if item.id == doc.document.documentID {
                            var result = item
                            
                            result.name = doc.document.get("name") as! String
                            result.uid = doc.document.get("uid") as! String
                            result.image = doc.document.get("image") as! String
                            result.date = (doc.document.get("date") as! Timestamp).dateValue()
                            result.total = doc.document.get("total") as! Int
                            
                            var foods = [Food]()
                            var seats = [Seat]()
                            
                            Firestore.firestore().collection("Order").document(doc.document.documentID).collection("Food").getDocuments { (snap, err) in
                                if err != nil {
                                    print((err?.localizedDescription)!)
                                    return
                                }
                                snap?.documents.forEach({ (doc) in
                                    let id = doc.documentID
                                    let count = doc.data()["count"] as! Int
                                    let price = doc.data()["price"] as! Int
                                    let name = doc.data()["name"] as! String
                                    let image = doc.data()["image"] as! String
                                    
                                    foods.append(Food(id: id, name: name, image: image, price: price, count: count))
                                })
                            }
                            
                            Firestore.firestore().collection("Order").document(doc.document.documentID).collection("Ticket").getDocuments { (snap, err) in
                                if err != nil {
                                    print((err?.localizedDescription)!)
                                    return
                                }
                                snap?.documents.forEach({ (doc) in
                                    let id = doc.documentID
                                    let row = doc.data()["row"] as! Int
                                    let colum = doc.data()["colum"] as! Int
                                    
                                    seats.append(Seat(id: id, colum: colum, row: row))
                                })
                                
                                result.foods = foods
                                result.seats = seats
                            }
                            return result
                        } else {
                            return item
                        }
                    })
                }
            })
        }
    }
    func getDataSeats(name:String) {
        Firestore.firestore().collection("Order").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let stamp = document.data()["date"] as! Timestamp
                    let date = stamp.dateValue()
                    Firestore.firestore().collection("Order").document(document.documentID).collection("Ticket").getDocuments { (snap, err) in
                        snap?.documents.forEach({ (doc) in
                            let id = fomartDaytoDate(date: date)
                            let colum = doc.data()["colum"] as! Int
                            let row = doc.data()["row"] as! Int
                            
                            self.data.append(Seat(id: id, colum: colum, row: row))
                        })
                    }
                }
            }
        }
        
    }
}
