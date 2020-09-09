//
//  NewListView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct NewListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>

    @ObservedObject var viewRouter: ViewRouter

    @State var text:String = ""
        
    @State private var created: Int? = nil
    
    @State private var copied = -1
    @State private var copiedID = 0
    
    @State private var ID = 0
    
    @State private var showAlert = false


    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Create New List")
                    .font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,20)
                
                // New List Name
                VStack(alignment: .leading){
                    Text("List Name")
                        .font(thisFont(size:15)).foregroundColor(Color.gray).offset(y: 5)
                    TextField("Enter List Name",text: $text)
                        .font(thisFont(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accentColor(.gray)
                }.padding(.horizontal,50).padding(.top,30)
                
                
                // Copy from Existing List
                Form {
                    Picker("Copy From List", selection: $copied){
                        Text("None\0").tag(-1)
                        ForEach(0..<self.lists.count) { index in
                            if self.lists[index].groupName! == self.viewRouter.curGroup {
                                Text(self.lists[index].name!).tag(index)
                            }
                        }
                    }
                }.foregroundColor(ColorManager.primary).padding(.top, 10).padding(.horizontal)
                
                // Navigates to newly created list
                NavigationLink(destination: ThisListView(viewRouter: self.viewRouter, newList: true, listID: self.ID), tag: 1, selection: $created) {
                    // Create Button
                    Button(action: {
                        
                        // Only creates list if it has name
                        if self.text != "" {
                            let list = ThisList(context: self.managedObjectContext)
                            list.name = self.text
                            list.groupName = self.viewRouter.curGroup
                            list.listID = Int.random(in: 1...Int.max)
                            
                            self.ID = list.listID
                            
                            
                            // checks if list was chosen
                            if(self.copied != -1) {
                                self.copiedID = self.lists[self.copied].listID
                              
                                copyList(fromID: self.copiedID, to: list.name!, toID: self.ID, persons: self.persons)
                            }

                            
                            // try to save
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.created = 1
                        } else {
                            self.showAlert.toggle()
                        }
                        
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(ColorManager.primary)
                                .cornerRadius(25)
                                .frame(width:150,height:50)
                                .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
                            Text("   CREATE   ")
                                .font(.system(size: 20)).bold()
                                .foregroundColor(Color.white)
                                .frame(alignment: .center)
                        }
                        
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Failed to Generate List!"), message: Text("Please Enter a Valid List Name"), dismissButton: .default(Text("OK")))
                    }
                    
                } // end NavLink
                    
                
                Text("For Group \"\(viewRouter.curGroup)\"")
                    .font(thisFont(size:15))
                    .foregroundColor(ColorManager.primary)
                    .bold()

                Spacer()

            } // end VStack
                .navigationBarTitle("", displayMode: .inline)
                .onDisappear(perform: {
                    self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                })
        } // end NavView
    }
}
