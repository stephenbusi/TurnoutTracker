//
//  NewEventView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/19/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct NewEventView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    
    @ObservedObject var viewRouter: ViewRouter

    func transferNames(listID: Int, listName: String, eventName: String) {
        for person in self.persons {
            if(person.listID == listID) {
                let newPerson = ThisEventPerson(context: self.managedObjectContext)
                
                newPerson.eventName = eventName
                newPerson.name = person.name!
                newPerson.title = person.title!
                newPerson.eventID = ID
                newPerson.groupName = self.viewRouter.curGroup
                newPerson.eventList = listName
                newPerson.eventDate = time
                
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    @State var showView = false
    @State private var time = Date()
    @State private var text = ""
    @State private var list = -1
    @State private var listName = ""
    
    @State private var created: Int? = nil
    
    @State private var showDate = false
    @State private var showList = false
    
    @State private var showAlert = false
    
    @State private var ID = 0
    
    var body: some View {
        NavigationView {
            VStack {
                // Title
                Text("Create New Event") .font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,20)
                

                // New Event Name
                VStack(alignment: .leading){
                    Text("Event Name").font(thisFont(size:15)).foregroundColor(Color.gray).offset(y: 5)
                    TextField("Enter Event Name",text: $text).font(thisFont(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accentColor(.gray)
                }.padding(.horizontal,50).padding(.top,30)
                
                
                Form {
                    // New Event Date
                    DatePicker("Select Date", selection:$time).accentColor(ColorManager.primary)
                    
                    // New Event List
                    Picker("Select List", selection: $list){
                        Text("Empty List\0").tag(-1)
                        ForEach(0..<self.lists.count) { index in
                            if self.lists[index].groupName! == self.viewRouter.curGroup {
                                Text(self.lists[index].name!).tag(index)
                            }
                        }
                    }
                    
                }.foregroundColor(ColorManager.primary).padding(.top, 10).padding(.horizontal)
                
                
                // Next Button
                NavigationLink(destination: ThisEventView(viewRouter: viewRouter, newEvent: true, ID: ID), tag: 1, selection: $created) {
                    
                    Button(action: {
                        
                        // Only creates event if it has name
                        if self.text != "" {
                            let newEvent = ThisEvent(context: self.managedObjectContext)
                            newEvent.name = self.text
                            newEvent.date = self.time
                            newEvent.eventID = Int.random(in: 1...Int.max)
                            newEvent.groupName = self.viewRouter.curGroup
                            
                            self.ID = newEvent.eventID

                            
                            // checks if list was chosen
                            if(self.list != -1) {
                                newEvent.thisList = self.lists[self.list].name!
                            }
                            else {
                                newEvent.thisList = ""
                            }
                            
                            // saves listName
                            self.listName = newEvent.thisList!
                            
                            // try to save event
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            
                            // try to transfer list names to event names
                            if self.list != -1 {
                                self.transferNames(listID: self.lists[self.list].listID, listName: self.listName, eventName: newEvent.name!)
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
                        Alert(title: Text("Failed to Generate Event!"), message: Text("Please Enter a Valid Event Name"), dismissButton: .default(Text("OK")))
                    }

                }// end NavLink
                
                Text("For Group \"\(viewRouter.curGroup)\"")
                    .font(thisFont(size:15))
                    .foregroundColor(ColorManager.primary)
                    .bold()
                
                Spacer()
            } // end VStack
                .navigationBarTitle("",displayMode: .inline)
            
        } // end Nav View
    }
}
