//
//  MyViewModel.swift
//  ToDo
//
//  Created by Sushil on 15/02/22.
//

import Foundation
import Firebase

class MyViewModel : ObservableObject{
    
    @Published var listItems:[Model1] = [Model1(id: "d", name: "ghv", mobile: "dfv")]
    @Published var name11:String = ""
    @Published var mobile11:String = ""
    
    @Published var id:String = ""
    
    let db = Firestore.firestore()
    
    
    func UpdateItems(){
        
        let ref = db.collection("Users").document(self.id)

        // Set the "capital" field of the city 'DC'
       ref.updateData([
        "name": self.name11,
        "mobile": self.mobile11
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                
                self.getData()
            }
        }
        
    }
    
    func AddItems(){
        
        db.collection("Users").addDocument(data: [
            "name": self.name11,
            "mobile": self.mobile11
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document Added Succesfully")
                
                self.getData()
            }
        }
    }
    
    func DeleteItem(id: String){
       
        db.collection("Users").document(id).delete(){ err in
            
            if let err = err{
                print("Error removing document: \(err)")
            } else{
                print("Document successfully removed!")
                self.getData()
            }
        }
        
    }
    
    func getData(){
       
        
        db.collection("Users").getDocuments { snapshot, err in
            
            if let err = err{
                print(err)
                
            } else{
                
                print(snapshot!.documents)
                
                
                self.listItems.removeAll()
                
                
                for document in snapshot!.documents{
                    
                    let name1 = document.data()["name"] ?? "None"
                    let mobile1 = document.data()["mobile"] ?? "None"
                   
                   // print(str)
                    let d1 = Model1(id: document.documentID ,name: name1 as! String, mobile: mobile1 as! String)
                    
                  //  let d2 = Model1(
                    
                    self.listItems.append(d1)
                }
            }
            
        }

    }
}
