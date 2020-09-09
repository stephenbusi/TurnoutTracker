//
//  GroupsBackButton.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct GroupsBackButton: View {
    @ObservedObject var viewRouter: ViewRouter
    
    
    // format
    var body: some View {
        Button(action: {
            self.viewRouter.page = "groups"
        }) {
            // Button Appearence
            HStack {
                Image(systemName: "chevron.left").imageScale(.large)
                VStack(alignment: .leading) {
                    Text("Groups")
                        .frame(width: 100, alignment: .leading).font(thisFont(size: 17))
                    Text("\(self.viewRouter.curGroup)")
                        .font(thisFont(size: 13)).foregroundColor(ColorManager.secondary).opacity(0.8)
                        .frame(width: 100, alignment: .leading).lineLimit(1)
                } // end VStack
            } // end HStack
            .foregroundColor(Color.white)
        }
    }
}
