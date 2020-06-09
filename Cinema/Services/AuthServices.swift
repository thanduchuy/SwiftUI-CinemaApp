//
//  AuthServices.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

class AuthServices: ObservableObject {
    @Published var user = User(id: "", name: "", avatar: "", email: "")
    let uid = Auth.auth().currentUser?.uid
    init() {
        Firestore.firestore().collection("Users").document(uid!).getDocument { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let id = (snap?.documentID)!
            let name = snap?.get("name") as! String
            let avatar = snap?.get("avatar") as! String
            let email = snap?.get("email") as! String
            
            self.user = User(id: id, name: name, avatar: avatar, email: email)
        }
    }
}


    func checkUser(completion: @escaping (Bool,String)-> Void) {
        let db = Firestore.firestore()
        db.collection("Users").getDocuments { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documents {
                if i.documentID == Auth.auth().currentUser?.uid {
                    completion(true,i.get("name") as! String)
                    return
                }
            }
            completion(false,"")
        }
    }
    func logOut() {
        try! Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "status")
        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
    }
    func createUser(name:String,email:String,imageData: Data,completion: @escaping (Bool)-> Void) {
        let db = Firestore.firestore()
        let storage = Storage.storage().reference()
        let uid = Auth.auth().currentUser?.uid
        
        storage.child("Avatar").child(uid!).putData(imageData, metadata: nil) { (_, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            storage.child("Avatar").child(uid!).downloadURL { (url, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                db.collection("Users").document(uid!).setData(["name":name,"email":email,"avatar":"\(url!)"]) { (err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    completion(true)
                    UserDefaults.standard.set(true, forKey: "status")
                    UserDefaults.standard.set(name, forKey: "user")
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }
            }
        }
}
