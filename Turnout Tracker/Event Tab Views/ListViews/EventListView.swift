//
//  EventListView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/10/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

import SwiftUI

struct EventListView: View {
    // name of event
    var name:String = ""
    // date of event
    var date = Date()
    
    // format
    var body: some View {
        VStack(alignment: .leading){
            Text(name)
                .font(thisFont(size: 18))
            Text("\(date, formatter: dateFormatter)")
                .font(thisFont(size: 12)).foregroundColor(Color.gray)
        }
    }
}
