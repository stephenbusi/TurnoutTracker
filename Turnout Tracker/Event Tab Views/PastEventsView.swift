//
//  PastEventsView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/7/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct PastEventsView: View {
        
        @Environment(\.managedObjectContext) var managedObjectContext
        @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    
        @ObservedObject var viewRouter: ViewRouter
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Past Events:").font(Font.title.bold()).padding(.leading, 13).padding(.top)
            
                List {
                  
                    // Second Section: List of People in List
                    Section() {
                            
                            // loops through all events
                        ForEach(self.events) { thisEvent in
                            if self.viewRouter.curGroup == thisEvent.groupName! {
                                if thisEvent.date! + 86400 < Date() {
                                    HStack{
                                        PastEventListView(name: thisEvent.name!, date: thisEvent.date!)
                                        
                                        // Link to this event
                                        NavigationLink("", destination: ThisEventView(viewRouter: self.viewRouter, ID: thisEvent.eventID).environment(\.managedObjectContext, self.managedObjectContext))
                                    }
                                }
                            }
                        }
                            // on deletion of name
                            .onDelete { indexSet in
                                let deleteItem = self.events[indexSet.first!]
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
                    .navigationBarTitle(Text("Past Events")).accentColor(Color.black)
                    .onDisappear(perform: {
                     self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                    })
                    
            }
               


        }
    }
