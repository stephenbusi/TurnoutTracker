//
//  Shows home page of app
//
//  Created by Stephen Boussarov on 9/8/20.
//

import SwiftUI

/*
    Showcases all groups in the apps in one clickable list.
 */
struct GroupsView: View {
    
    // holds the names of the current group and the page shown
    @ObservedObject var viewRouter: ViewRouter
    
    // generates all data items
    @FetchRequest(fetchRequest: Group.getAllGroups()) var groups:FetchedResults<Group>
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var eventPersons:FetchedResults<ThisEventPerson>
    
    // contains the current data environment
    @Environment(\.managedObjectContext) var managedObjectContext

    
    // determines if info box should be shown
    @State private var showView = false
    
    
    var body: some View {

            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: CGFloat(100))
                        .foregroundColor(ColorManager.primary)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
                
                VStack {
                    Rectangle()
                        .frame(height: 127)
                        .foregroundColor(ColorManager.primary)
                    Spacer()
                }

    
                VStack {
                    
                    HStack {
                        Spacer()
                        // Title
                        Text("Groups").font(Font.custom("Futura", size: 18)).foregroundColor(Color.white)
                            .padding(.leading,10)
                        
                        Spacer()
                        
                        // Button to show info box
                        Button(action: {
                            self.showView.toggle()
                        }) {
                            Image(systemName: "info.circle.fill").foregroundColor(.white).padding(.trailing)
                        }
                    }.padding(.top,100)
                    
                    
                    // List of all groups
                    List {
                        ForEach (self.groups) { group in
                            HStack {
                                
                                Button(action: {
                                    // changes page being shown
                                    self.viewRouter.page = "tabs"
                                    // changes name of current group
                                    self.viewRouter.curGroup = group.name!
                                }) {
                                    Text("\(group.name!)").font(thisFont(size: 25)).padding(.leading,10)
                                    }
                                .frame(width:320,alignment: .leading).padding(.vertical,8)
                                
                                
                                Image(systemName: "chevron.right").frame(alignment: .trailing).foregroundColor(Color.gray).padding(.trailing,10)
                                
                            }
                                    .background(Color.white).cornerRadius(5).foregroundColor(ColorManager.primary)
                                    .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
                        }
                        // on deletion of name
                        .onDelete { indexSet in
                            let deleteItem = self.groups[indexSet.first!]
                            
                            // deletes all corresponding persons in group
                            for person in self.persons {
                                if person.groupName! == deleteItem.name! {
                                    self.managedObjectContext.delete(person)
                                }
                            }
                            
                            // deletes all corresponding lists in group
                            for list in self.lists {
                                if list.groupName! == deleteItem.name! {
                                    self.managedObjectContext.delete(list)
                                }
                            }
                            
                            // deletes all corresponding events and eventPersons in group
                            for event in self.events {
                                if event.groupName! == deleteItem.name! {
                                    for person in self.eventPersons {
                                        if person.eventID == event.eventID {
                                            self.managedObjectContext.delete(person)
                                        }
                                    }
                                    self.managedObjectContext.delete(event)
                                }
                            }
                            
                            self.managedObjectContext.delete(deleteItem)
                            
                            // attempt to save deletion
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    } // end List
                        
                
                    // Removed App Description
                    HStack {
                        Spacer()
                        VStack {
                            Text("")
                        }
                        Spacer()
                    }
                } // end VStack
                
                // App Title
                VStack{
                    Text("Turnout Tracker").font(.custom("Futura Bold", size: 40)).padding(.top,25)
                    Spacer()
                }.foregroundColor(Color.white)
                
                // Button to add new group
                AddButtonGroupView()
                
                if showView {
                    Rectangle()
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.vertical)
                        .onTapGesture {
                            self.showView = false
                        }
                    InfoButtonGroupsView(showPopUp: $showView)
                }
            } // end ZStack

    }
}

