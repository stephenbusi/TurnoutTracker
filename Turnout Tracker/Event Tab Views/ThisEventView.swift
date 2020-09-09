//
//  ThisEventView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/10/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct ThisEventView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>

    @ObservedObject var viewRouter: ViewRouter
    
    @State private var newPersonName = ""
    @State private var newPersonTitle = ""
    
    var thisEvent: ThisEvent {
        for event in events {
            if event.eventID == ID {
                return event
            }
        }
        return events[0]
    }
    
    
    @State var newEvent = false
    @State var ID = 0
            
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                
                // Title
                HStack {
                    
                    Text(self.thisEvent.name!).font(.custom("Futura Bold", size: 28))
                    EditButtonEventView(viewRouter: viewRouter, thisEventID: ID).padding(.bottom,12)
                }.frame(width: 350, alignment: .leading).padding(.leading, 18).padding(.top)
                
                // Date Info
                HStack{
                    Text("Date:").font(thisFont(size: 15)).fontWeight(.bold)
                    Text("\(self.thisEvent.date!, formatter: dateFormatter)")
                }.font(thisFont(size: 15)).padding(.leading, 18)
                
                NavigationLink(destination: ThisEventStatsView(viewRouter: viewRouter, thisEvent: thisEvent)) {
                    Text("Event Statistics").foregroundColor(ColorManager.primary)
                }.padding(.leading, 18).padding(.top,12)
                
                
                List {
                    
                    // First Section: Adding new person
                    Section(header:
                        Text("Add New Person:")
                            .foregroundColor(Color.white).font(thisFont(size: 18))
                            .fontWeight(.semibold)
                    ) {
                        
                        HStack {
                            HStack {
                                TextField("Name", text: self.$newPersonName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical).accentColor(.gray)
                                TextField("Description", text: self.$newPersonTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical).accentColor(.gray)
                            }
                            
                            Button(action: {
                                // if name input is filled
                                if self.newPersonName != "" {
                                    // assign new person
                                    let person = ThisEventPerson(context: self.managedObjectContext)
                                    person.title = self.newPersonTitle
                                    person.name = self.newPersonName
                                    person.eventName = self.thisEvent.name!
                                    person.eventID = self.ID
                                    person.groupName = self.viewRouter.curGroup
                                    person.eventDate = self.thisEvent.date!
                                    person.eventList = ""
                                    
                                    // try to save
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                                
                                // clear input field
                                self.newPersonTitle = ""
                                self.newPersonName = ""
                                // removes keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                            }) {
                                Image(systemName: "plus.circle.fill").foregroundColor(ColorManager.primary)
                                    .imageScale(.large)
                            }
                            
                        }
                    }.font(.headline)
                    
                    // Second Section: List of People in List
                    Section(header:
                        Text("People:")
                            .foregroundColor(Color.white).font(thisFont(size: 18))
                            .fontWeight(.semibold)
                    ) {
                        ForEach(self.persons) { person in
                            if person.eventName == self.thisEvent.name! {
                                if person.eventID == self.ID {
                                    HStack {
                                        PersonView(name: person.name!,title: person.title!)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            person.checked = (person.checked == true) ? false : true
                                            
                                            // try and save change
                                            do {
                                                try self.managedObjectContext.save()
                                            } catch {
                                                print(error)
                                            }
                                        }) {
                                            if person.checked {
                                                Image(systemName: "checkmark.square.fill").foregroundColor(ColorManager.primary).imageScale(.large)
                                            } else {
                                                Image(systemName: "square").foregroundColor(Color.gray).imageScale(.large)
                                            }
                                        }// end of button
                                        
                                        
                                        
                                    }
                                }
                            }
                        }
                            
                        // on deletion of name
                        .onDelete { indexSet in
                            let deleteItem = self.persons[indexSet.first!]
                            self.managedObjectContext.delete(deleteItem)
                                                    
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    }
                } // end List
                    .navigationBarColor(backgroundColor: UIColor.white,textColor: UIColor.black)
                
                    .navigationBarItems(trailing: topButton(bool: newEvent).foregroundColor(ColorManager.primary))
                
            } // end VStack
               .navigationBarBackButtonHidden(self.newEvent)
                .onDisappear(perform: {
                    self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                })

            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        let copyboard = UIPasteboard.general
                        copyboard.string = ""
                        for person in self.persons {
                            if person.eventName == self.thisEvent.name! {
                                if person.eventID == self.ID {
                                    if person.checked {
                                        copyboard.string! += person.name! + "\n"
                                    }
                                }
                            }
                        }
                        print (copyboard.string!)
                    }) {
                        CopyAttendedButtonView().padding(.trailing,10)
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        let copyboard = UIPasteboard.general
                        copyboard.string = ""
                        for person in self.persons {
                            if person.eventName == self.thisEvent.name! {
                                if person.eventID == self.ID {
                                    if !person.checked {
                                        copyboard.string! += person.name! + "\n"
                                    }
                                }
                            }
                        }
                        
                        print (copyboard.string!)
                    }) {
                        CopyMissingButtonView().padding(.trailing,10)
                    }
                    
                }.padding(.bottom,10)
            }
            
            

            
            
            
    } // end ZStack
    }
}
