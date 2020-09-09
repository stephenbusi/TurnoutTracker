//
//  PersonStatsView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct PersonStatsView: View {
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>

    @ObservedObject var viewRouter: ViewRouter
    
    public var totEvents: Double {
        var returnVal = 0.0
        
        for thisPerson in persons {
            if thisPerson.name! == person {
                returnVal += 1
            }
        }
        
        return returnVal
    }
    
    public var attended: Double {
        var returnVal = 0.0
        
        for thisPerson in persons {
            if thisPerson.name! == person {
                if thisPerson.checked {
                    returnVal += 1
                }
            }
        }
        
        return returnVal
    }
    
    @State var person = ""
    
    var body: some View {
        VStack {
            Text("Attendee Statistics")
                .font(thisFont(size: 30)).fontWeight(.bold).padding(.vertical).foregroundColor(ColorManager.secondary)
            
            
            
            // Box Data
            VStack {
                HStack {
                    Text("Name:\t")
                        .padding(.leading)
                    Spacer()
                    Text("\(person)")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }
                
                HStack {
                    Text("Attended Events:")
                        .padding(.leading)
                    Spacer()
                    Text("\(attended, specifier: "%.0f")/\(totEvents, specifier: "%.0f")")
                        .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                }.padding(.top)
                
                HStack {
                    Text("Attendance Percentage:")
                        .padding(.leading)
                    Spacer()
                    
                    if totEvents != 0 {
                        Text("\(attended/totEvents*100, specifier: "%.0f")%")
                            .fontWeight(.semibold).padding(.trailing).lineLimit(1)
                    } else {
                        Text("0%").fontWeight(.semibold).padding(.trailing).lineLimit(1)
                    }
                    
                }.padding(.top)
            }
                .font(thisFont(size:18)).frame(width: 340).padding(.vertical).background(ColorManager.secondary).cornerRadius(5).foregroundColor(Color.white)
            
            
             
            List {
                ForEach (persons) { thisPerson in
                    if thisPerson.name! == self.person {

                        if thisPerson.checked {
                            AttendeeEventView(viewRouter: self.viewRouter, thisPerson: thisPerson)
                        } else {
                            AttendeeEventView(viewRouter: self.viewRouter, thisPerson: thisPerson)        .listRowBackground(Color.red.opacity(0.3))
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

