//
//  ActivitySevice.swift
//  Cinema
//
//  Created by MacBook Pro on 4/10/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

class ActivitySevice: ObservableObject {
    @Published var data = [Activity]()
    init() {
        Firestore.firestore().collection("Activity").whereField("uid", isEqualTo: (Auth.auth().currentUser?.uid)!).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            snap?.documentChanges.forEach({ (doc) in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let uid = doc.document.get("uid") as! String
                    let name = doc.document.get("name") as! String
                    let image = doc.document.get("image") as! String
                    
                    self.data.append(Activity(id: id, name: name, image: image, uid: uid))
                }
                if doc.type == .modified {
                    self.data = self.data.map({ (item) -> Activity in
                        if item.id == doc.document.documentID {
                            var temp = item
                            temp.uid = doc.document.get("uid") as! String
                            temp.name = doc.document.get("name") as! String
                            temp.image = doc.document.get("image") as! String
                            return temp
                        } else {
                            return item
                        }
                    })
                }
                if doc.type == .removed {
                    self.data = self.data.filter({ (item) -> Bool in
                        return item.id != doc.document.documentID
                    })
                }
            })
        
        }
    }
}

