//
//  EditButtonActionViews.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/16/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct CancelButtonView: View {
    var body: some View {
        Button(action: {
            UIApplication.shared.windows[1].rootViewController?.dismiss(animated: true, completion: {})
        }) {
            Text("Cancel").foregroundColor(ColorManager.primary)
        }
    }
}

struct EditButtonGroupView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter

    @State var thisGroup: String
    
    var body: some View {
        Button(action: {
            let alertHC = UIHostingController(rootView: EditGroupView(viewRouter: self.viewRouter).environment(\.managedObjectContext, self.managedObjectContext))
            

            alertHC.preferredContentSize = CGSize(width: -50, height: -50)
            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

            UIApplication.shared.windows[1].rootViewController?.present(alertHC, animated: true)
        }) {
            Image(systemName: "pencil").foregroundColor(ColorManager.primary).imageScale(.small)
            
        }
    }
}


struct EditGroupView: View {
    @FetchRequest(fetchRequest: Group.getAllGroups()) var groups:FetchedResults<Group>
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var eventPersons:FetchedResults<ThisEventPerson>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter

    
    @State var newName = ""
    
    var body: some View {
            
        VStack {
            // Buttons
            HStack {
                CancelButtonView()
                Spacer()
                
                // Save Button
                Button(action: {
                    // if name has been changed
                    if self.newName != "" {
                        // old name of group
                        let oldName = self.viewRouter.curGroup
                        
                        // changes curGroup String
                        self.viewRouter.curGroup = self.newName
                        
                        // changes Group object
                        for group in self.groups {
                            if group.name! == oldName {
                                group.name = self.newName
                            }
                        }
                        
                        // Changes all persons
                        for person in self.persons {
                            if person.groupName! == oldName {
                                person.groupName = self.newName
                            }
                        }
                        
                        // Changes all lists
                        for list in self.lists {
                            if list.groupName! == oldName {
                                list.groupName = self.newName
                            }
                        }
                        
                        // Changes all events
                        for event in self.events {
                            if event.groupName! == oldName {
                                event.groupName = self.newName
                            }
                        }
                        
                        // Changes all event persons
                        for person in self.eventPersons {
                            if person.groupName! == oldName {
                                person.groupName = self.newName
                            }
                        }
                        
                        // try to save new group name
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                    
                    UIApplication.shared.windows[1].rootViewController?.dismiss(animated: true, completion: {})

                }) {
                    Text("Save").foregroundColor(ColorManager.primary)
                }
            }.padding(.horizontal, 30).padding(.top)
            
            // Title
            Text("Edit Group").font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,100)
            

            // New Group Name
            VStack(alignment: .leading){
                Text("Group Name").font(thisFont(size:15)).foregroundColor(Color.gray)
                TextField("New Group Name",text: $newName).font(thisFont(size: 15))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accentColor(.gray)
            }.padding(.horizontal,50).padding(.top,80)
            Spacer()
            
        } // end VStack

    }
}




struct EditButtonEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter
    
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    
    public var thisEvent: ThisEvent {
        for event in events {
            if thisEventID == event.eventID {
                return event
            }
        }
        return ThisEvent()
    }
    
    @State var thisEventID: Int
    
    var body: some View {
        Button(action: {
            let alertHC = UIHostingController(rootView: EditEventView(viewRouter: self.viewRouter, time: self.thisEvent.date!,oldTime: self.thisEvent.date!, thisEvent: self.thisEvent).environment(\.managedObjectContext, self.managedObjectContext))
            

            alertHC.preferredContentSize = CGSize(width: -50, height: -50)
            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

            UIApplication.shared.windows[1].rootViewController?.present(alertHC, animated: true)
        }) {
            Image(systemName: "pencil").foregroundColor(ColorManager.primary).imageScale(.small)
        }
    }
}

struct EditEventView: View {
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var eventPersons:FetchedResults<ThisEventPerson>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter

    @State var time: Date
    
    @State var oldTime: Date
    
    @State var thisEvent: ThisEvent
    
    @State var newName = ""
    
    var body: some View {
            
        VStack {
            // Buttons
            HStack {
                CancelButtonView()
                Spacer()
                
                // Save Button
                Button(action: {
                    // if name has been changed
                    if self.newName != "" || self.time != self.oldTime {
                        
                        // if name wasn't changed
                        if self.newName == "" {
                            self.newName = self.thisEvent.name!
                        }
                        
                        // changes thisEvent name
                        self.thisEvent.name = self.newName
                        
                        self.thisEvent.date = self.time
                        

                        // Changes all event persons
                        for person in self.eventPersons {
                            if person.eventID == self.thisEvent.eventID {
                                person.eventName = self.newName
                                person.eventDate = self.time
                            }
                        }
                        
                        // try to save new event info
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                    
                    UIApplication.shared.windows[1].rootViewController?.dismiss(animated: true, completion: {})

                }) {
                    Text("Save").foregroundColor(ColorManager.primary)
                }
            }.padding(.horizontal, 30).padding(.top)
            
            // Title
            Text("Edit Event")
                .font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,100)
            

            // New Event Name
            VStack(alignment: .leading){
                Text("Event Name").font(thisFont(size:15)).foregroundColor(Color.gray).offset(y: 5)
                TextField("New Event Name",text: $newName).font(thisFont(size: 15))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accentColor(.gray)
            }.padding(.horizontal,50).padding(.top,80)
            
            // New Event Date
            Form {
                DatePicker("Select New Date", selection:$time).padding(.horizontal).accentColor(ColorManager.primary)
            }.foregroundColor(ColorManager.primary).padding(.top, 10).padding(.horizontal)
            Spacer()
            
        } // end VStack

    }
}




struct EditButtonListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter
    
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>

    var thisList: ThisList {
        for list in lists {
                if thisListID == list.listID {
                    return list
                }
            }
        return ThisList()
    }
    
    @State var thisListID: Int
    
    
    var body: some View {
        Button(action: {
            let alertHC = UIHostingController(rootView: EditListView(viewRouter: self.viewRouter, thisList: self.thisList).environment(\.managedObjectContext, self.managedObjectContext))
            

            alertHC.preferredContentSize = CGSize(width: -50, height: -50)
            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

            UIApplication.shared.windows[1].rootViewController?.present(alertHC, animated: true)
        }) {
            Image(systemName: "pencil").foregroundColor(ColorManager.primary).imageScale(.small)
        }
    }
}

struct EditListView: View {
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter

    
    @State var thisList: ThisList
    
    @State var newName = ""
    
    var body: some View {
            
        VStack {
            // Buttons
            HStack {
                CancelButtonView()
                Spacer()
                
                // Save Button
                Button(action: {
                    // if name has been changed
                    if self.newName != ""{
                        
                        // changes thisList name
                        self.thisList.name = self.newName
                                            

                        // Changes all persons
                        for person in self.persons {
                            if person.listID == self.thisList.listID {
                                person.listName = self.newName
                            }
                        }
                        
                        // try to save new event info
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                    
                    UIApplication.shared.windows[1].rootViewController?.dismiss(animated: true, completion: {})

                }) {
                    Text("Save").foregroundColor(ColorManager.primary)
                }
            }.padding(.horizontal, 30).padding(.top)
            
            // Title
            Text("Edit List")
                .font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,100)
            

            // New Event Name
            VStack(alignment: .leading){
                Text("List Name")
                    .font(thisFont(size:15)).foregroundColor(Color.gray).offset(y: 5)
                TextField("New List Name",text: $newName)
                    .font(thisFont(size: 15)).textFieldStyle(RoundedBorderTextFieldStyle()).accentColor(.gray)
            }.padding(.horizontal,50).padding(.top,80)
            
            Spacer()
            
        } // end VStack

    }
}
