//
//  ToDoApp.swift
//  ToDo
//
//  Created by Sushil on 15/02/22.
//

import SwiftUI
import Firebase

@main
struct ToDoApp: App {
    @AppStorage("c1")var c1 = false
    init(){
           FirebaseApp.configure()
       }
       var body: some Scene {
           WindowGroup {
               ContentView().environment(\.colorScheme, c1 ? .dark:.light)
                   .environmentObject(MyViewModel())
           }
       }
}
