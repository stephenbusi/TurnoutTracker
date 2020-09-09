//
//  GroupStatsView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct GroupStatsView: View {
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>

    @ObservedObject var viewRouter: ViewRouter
    
    public var totalEvents: Int {
        var returnVal = 0
        // sets totalEvents
        for event in events {
            if event.groupName! == self.viewRouter.curGroup {
                if(event.date! < Date()) {
                    returnVal += 1
                }
            }
        }
        return returnVal
    }
    
    public var attPercent: Double {
        var attended = 0.0
        var totPossible = 0.0
        var returnVal = 100.0
        
        // Calculates total attendance percentage
        for person in persons {
            if person.groupName! == self.viewRouter.curGroup {
                if person.eventDate! < Date() {
                    if person.checked {
                        attended += 1
                    }
                    totPossible += 1
                }
            }
        }
        
        // if total persons is not zero
        if totPossible != 0 {
            returnVal = attended/Double(totPossible) * 100
        }
        return returnVal
    }
    
        
    
    var body: some View {

        
        VStack {
            // Title
            Text("Group Statistics")
                .font(thisFont(size: 30)).fontWeight(.bold).padding(.vertical).foregroundColor(ColorManager.secondary)
            
            // Box Data
            VStack {
                HStack {
                    Text("Name:\t")
                        .padding(.leading)
                    Spacer()
                    Text("\(self.viewRouter.curGroup)")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }
                
                HStack {
                    Text("Total Events:")
                        .padding(.leading)
                    Spacer()
                    Text("\(totalEvents)")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }.padding(.top)
                
                HStack {
                    Text("Attendance Percentage:")
                        .padding(.leading)
                    Spacer()
                    Text("\(attPercent, specifier: "%.0f")%")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }.padding(.top)
            }
                .font(thisFont(size:18)).frame(width: 340).padding(.vertical).background(ColorManager.secondary).cornerRadius(5).foregroundColor(Color.white)
            
            

            
            
            List {
                ForEach (events) { thisEvent in
                    if thisEvent.groupName! == self.viewRouter.curGroup {
                        if thisEvent.date! < Date() {
                            GroupEventStatsView(viewRouter: self.viewRouter, thisEvent: thisEvent)
                        }
                    }
                }
            } // end List
        } // end VStack
            .onDisappear(perform: {
                self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
            })
    }
}
