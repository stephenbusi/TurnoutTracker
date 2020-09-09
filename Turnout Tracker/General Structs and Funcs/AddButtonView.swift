//
//  AddButtonView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct AddButtonGroupView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    // format
    var body: some View {
        // Actual Button View
        VStack(alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                    // creates popup of NewEventView
                    let alertHC = UIHostingController(rootView: NewGroupView().environment(\.managedObjectContext, self.managedObjectContext))
                    

                    alertHC.preferredContentSize = CGSize(width: -50, height: -50)
                    alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

                    UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                }) {
                    AddButton()
                }
                
            } // end HStack
                .padding(.trailing, 30)
        } // end VStack
            .padding(.bottom,40)
    }
}

struct AddButtonEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewRouter: ViewRouter
        
    // format
    var body: some View {
        // Actual Button View
        VStack(alignment: .trailing) {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                    // creates popup of NewEventView
                    let alertHC = UIHostingController(rootView: NewEventView(viewRouter: self.viewRouter).environment(\.managedObjectContext, self.managedObjectContext))
                    

                    alertHC.preferredContentSize = CGSize(width: -50, height: -50)
                    alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

                    UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                }) {
                    AddButton()
                }
                
            } // end HStack
                .padding(.trailing,20)
        } // end VStack
            .padding(.bottom)
    }
}

struct AddButtonListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var viewRouter: ViewRouter

    
    // format
        var body: some View {
            // Actual Button View
            VStack(alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        
                        // creates popup of NewEventView
                        let alertHC = UIHostingController(rootView: NewListView(viewRouter: self.viewRouter).environment(\.managedObjectContext, self.managedObjectContext))
                        

                        alertHC.preferredContentSize = CGSize(width: -50, height: -50)
                        alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

                        UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)

                    }) {
                        AddButton()
                    }
                    
                } // end HStack
                    .padding(.trailing,20)
            } // end VStack
                .padding(.bottom)
        }
    }
