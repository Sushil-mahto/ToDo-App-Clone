//
//  ContentView.swift
//  ToDo
//
//  Created by Sushil on 15/02/22.
//

import SwiftUI

struct ContentView: View {
        @Environment(\.colorScheme) var cs
        @AppStorage("c1") var c1 = false
    
       @EnvironmentObject var vm:MyViewModel
       
       @State var s1:Bool = false
       
       @State var s2:Bool = false
       
       var body: some View {
           
           ZStack(alignment: .top){
               Color("mybackground").edgesIgnoringSafeArea(.all)
                           Image(systemName: "moon.fill")
                   .padding(.leading,300)
                               .font(.title)
                               .onTapGesture {
                                   c1.toggle()
                                   
                               }
               VStack {
              Text("MY DIARY")
                       .padding(.trailing,200)
                       .font(.title)
                       .foregroundColor(Color.black)
                       .onTapGesture {
                           s2 = false
                       }
                   Rectangle()
                       .frame(width: UIScreen.main.bounds.width-20, height: 1, alignment: .center)
                   
               List{
                   ForEach(vm.listItems){ x in
                       
                       VStack(alignment:.leading){
                           Text(" \(x.name)")
                               .font(.title2)
                               .onTapGesture {
                                   s1.toggle()
                                   s2 = true
                                   
                                   vm.id = x.id
                                   vm.name11 = x.name
                                   vm.mobile11 = x.mobile
                               
                               }
                           /*Text("Mobile: \(x.mobile)")
                               .font(.title3)
                               .foregroundColor(Color.red)*/
                           
                       }.swipeActions {
                           Button("Delete"){
                               vm.DeleteItem(id: x.id)
                               
                           }.tint(Color.red)
                       }
                       
                   }
                   
               }.listStyle(.plain)
              Spacer()
                   Image(systemName: "plus.circle")
                       .padding(.leading,300)
                       .font(.largeTitle)
                       .foregroundColor(Color.green)
                       .onTapGesture{
                           s1.toggle()
                           s2 = false
                       }
                   
                   
            
           }
           .onAppear(){
               vm.getData()
           }
           
           .sheet(isPresented: $s1) {
               
               if(!s2){
                   CreateData(title: "Add Data", submitButton: "Submit")
               } else{
                   CreateData(title: "Update Data", submitButton: "Update")
               }
              
              
           }
               
       }
           
          
       
           
       
   }

   struct CreateData: View{
       
       @EnvironmentObject var vm:MyViewModel
       
       let title:String
       let submitButton:String
       
       @Environment(\.presentationMode) var pm
       
       var body: some View{
           
           ZStack(alignment:.top){
               VStack{
                   HStack{
               Image(systemName: "square.and.arrow.down")
                   .font(.title)
                   .padding(.leading,300)
                   
                   .foregroundColor(Color.black)
                   .shadow(color: Color.gray, radius: 6, x: 1, y: 3)
                   .onTapGesture {
                       if(submitButton == "Submit"){
                           vm.AddItems()
                       } else{
                           vm.UpdateItems()
                           
                       }
                       
                       pm.wrappedValue.dismiss()
                   }
               }
                
                   HStack{
                   Text("\(title)")
                       .font(.largeTitle)
                       
                   }
                   
               VStack{
                   
                   TextField("Enter Name", text: $vm.name11)
                       
                
                   TextEditor( text: $vm.mobile11)
                       .frame(width: UIScreen.main.bounds.width-10, height: 400, alignment: .center)
                       .padding()
               }
                   Spacer()
                   
               }
           }
           
       }
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
    }
}
