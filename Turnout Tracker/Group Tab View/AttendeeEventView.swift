//
//  AttendeeEventView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/16/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct AttendeeEventView: View {
    @ObservedObject var viewRouter: ViewRouter
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var thisPerson: ThisEventPerson
    
    var body: some View {
        Button(action: {
            let alertHC = UIHostingController(rootView: ThisEventView(viewRouter: self.viewRouter, ID: self.thisPerson.eventID).environment(\.managedObjectContext, self.managedObjectContext))
            

            alertHC.preferredContentSize = CGSize(width: -50, height: -50)
            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)
        }) {
            VStack(alignment: .leading) {
                Text("\(thisPerson.eventName!)").foregroundColor(ColorManager.primary).padding(.leading,3)
                Text("\(thisPerson.eventDate!, formatter: dateFormatter)").foregroundColor(Color.gray).font(.caption).padding(.leading,3)
            }.padding(.vertical, 5).frame(maxWidth: .infinity, alignment: .leading)
            
        } // end button
    }
}

