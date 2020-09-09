//
//  MainEventsTabView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/19/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct MainEventsTabView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State var showView = false

    
    func isGreen(date: Date) -> Bool {
        if date + 3600 >= Date() && date <= Date() {
            return true
        }
        return false
    }

    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                // Background Image
                Image(systemName: "calendar").resizable()
                    .frame(width: 300.0, height: 300.0).opacity(0.5)
                .foregroundColor(ColorManager.primary)
                .position(x: 50, y: 500)
                    .opacity(0.1)
                
                VStack() {
                    
                    // Title
                    Text("Upcoming Events:")
                        .font(thisFont(size: 30)).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal).padding(.top,30).foregroundColor(ColorManager.secondary)
                
                    // List of upcoming events
                    List {
                        if (events.count != 0) {
                            // loops through all events
                            ForEach(self.events) { thisEvent in
                                if self.viewRouter.curGroup == thisEvent.groupName! {
                                    // checks to see if event has happened yet (upto 1 day past)
                                    if thisEvent.date! + 43200 > Date() {
                                        HStack{
                                            // Event View with link to corresponding page
                                            if self.isGreen(date: thisEvent.date!) {
                                                // make background green, if event is current
                                                EventListView(name: thisEvent.name!, date: thisEvent.date!).foregroundColor(Color.green)
                                            } else {
                                                EventListView(name: thisEvent.name!, date: thisEvent.date!)
                                            }
                                                
                                            // Link to this event
                                            NavigationLink("", destination: ThisEventView(viewRouter: self.viewRouter, ID: thisEvent.eventID).environment(\.managedObjectContext, self.managedObjectContext))
                                        }
                                    }
                                }
                            }
                            // on deletion of name
                            .onDelete { indexSet in
                                let deleteItem = self.events[indexSet.first!]
                                
                                // deletes all corresponding names in event
                                let eventName = deleteItem.name
                                for person in self.persons {
                                    if person.eventName! == eventName {
                                        self.managedObjectContext.delete(person)
                                    }
                                }
                                
                                self.managedObjectContext.delete(deleteItem)
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                            }
                        } else {
                            Text("Upcoming events will appear here").foregroundColor(Color.gray).font(.caption)
                        }
                    }
                    
                    // Link to see past events
                    NavigationLink(destination: PastEventsView(viewRouter: viewRouter)) {
                        Text("View Past Events")
                            .font(thisFont(size: 25)).padding(.horizontal).accentColor(ColorManager.primary).padding(.bottom,100).padding(.top,5)
                    }
                    
                    // App Description
                    AppDescription()
                } // end VStack
                .navigationBarTitle("Events", displayMode: .inline)
                .navigationBarItems(leading: GroupsBackButton(viewRouter: viewRouter), trailing:
                    Button(action: {
                        self.showView.toggle()
                    }) {
                        Image(systemName: "info.circle.fill").foregroundColor(.white)
                    })
                    .navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                
                AddButtonEventView(viewRouter: viewRouter)
                
                
                if showView {
                    Rectangle()
                        .opacity(0.3)
                        .onTapGesture {
                            self.showView = false
                        }
                    InfoButtonEventsView(showPopUp: $showView)

                }
                
            }// end ZStack
        } // end NavView
    }
}


