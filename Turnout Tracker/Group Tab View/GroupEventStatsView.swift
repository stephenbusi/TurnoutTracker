//
//  GroupEventStatsView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/16/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct GroupEventStatsView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>
    
    @State var thisEvent: ThisEvent
        
    var attendedPercent: Double {
        var totalPeople:Double = 0
        var attendPeople:Double = 0
        
        for thisPerson in self.persons {
            // checks if person is in event
            if thisPerson.eventID == thisEvent.eventID {
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
    
    var body: some View {
        Button(action: {
            let alertHC = UIHostingController(rootView: ThisEventView(viewRouter: self.viewRouter, ID: self.thisEvent.eventID).environment(\.managedObjectContext, self.managedObjectContext))
            

            alertHC.preferredContentSize = CGSize(width: -50, height: -50)
            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)
        }) {
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(thisEvent.name!)").foregroundColor(ColorManager.primary).padding(.leading,3)
                    Text("\(thisEvent.date!, formatter: dateFormatter)").foregroundColor(Color.gray).font(.caption).padding(.leading,3)
                }.padding(.vertical, 5).frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(attendedPercent, specifier: "%.0f")%").font(Font.body).padding(.top).foregroundColor(Color.gray)
                }
        } // end button
    }
}
