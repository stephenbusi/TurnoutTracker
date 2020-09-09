//
//  PastEventListView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/10/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct PastEventListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>

    
    // name of person
    var name:String = ""
    // date of event
    var date = Date()
    
    
    var attendedPercent: Double {
        var totalPeople:Double = 0
        var attendPeople:Double = 0
        
        for thisPerson in self.persons {
            // checks if person is in event
            if thisPerson.eventName! == name {
                totalPeople += 1
                // checks if person attended
                if thisPerson.checked {
                    attendPeople += 1
                    
                }
            }
        }
        
        if totalPeople > 0 {
            return attendPeople / totalPeople * 100
        }
        return 100
    }
        
    
    
    // format
    var body: some View {
        
        HStack {
            VStack(alignment: .leading){
                Text(name)
                    .font(thisFont(size: 18))
                Text("\(date, formatter: dateFormatter)")
                    .font(thisFont(size: 12))
            }.frame(width: 160,alignment: .leading)
            
            Text("Attendance Percentage: \(attendedPercent, specifier: "%.0f")%")
                .frame(width:110).font(thisFont(size: 12)).foregroundColor(ColorManager.primary)
        }
        
    }
}
