//
//  ThisEventStatsView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/17/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct ThisEventStatsView: View {
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>

    @ObservedObject var viewRouter: ViewRouter
    
    var totPossible: Double {
        var returnVal = 0.0
        
        for person in persons {
            if person.groupName! == self.viewRouter.curGroup {
                if person.eventID == thisEvent.eventID {
                    returnVal += 1
                }
            }
        }
        return returnVal
    }
    
    var attended: Double {
        var returnVal = 0.0
        
        for person in persons {
            if person.groupName! == self.viewRouter.curGroup {
                if person.eventID == thisEvent.eventID {
                    if person.checked {
                        returnVal += 1
                    }
                }
            }
        }
        
        return returnVal
    }
    
    var thisEvent: ThisEvent
    
    public var attPercent: Double {
        var returnVal = 100.0
        
        // if total persons is not zero
        if totPossible != 0 {
            returnVal = attended/Double(totPossible) * 100
        }
        return returnVal
    }
    
        
    
    var body: some View {

        VStack {
            // Title
            Text("Event Statistics")
                .font(thisFont(size: 30)).fontWeight(.bold).padding(.vertical).foregroundColor(ColorManager.secondary)
            
            // Box Data
            VStack {
                HStack {
                    Text("Name:\t")
                        .padding(.leading)
                    Spacer()
                    Text("\(self.thisEvent.name!)")                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }
                
                HStack {
                    Text("Date:")
                        .padding(.leading)
                    Spacer()
                    Text("\(self.thisEvent.date!, formatter: dateFormatterSlash)")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }.padding(.top)
                
                HStack {
                    Text("People Attended:")
                        .padding(.leading)
                    Spacer()
                    Text("\(self.attended, specifier: "%.0f")/\(self.totPossible, specifier: "%.0f")")
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
            
            
            
            // Lists out all names
            List {
                ForEach (persons) { person in
                    if person.eventID == self.thisEvent.eventID {
                        if(person.checked) {
                            PersonView(name: person.name!,title: person.title!)
                        } else {
                            PersonView(name: person.name!,title: person.title!).listRowBackground(Color.red.opacity(0.3))

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
