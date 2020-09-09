//
//  PersonView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/21/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct PersonView: View {
    // name of person
    var name:String = ""
    // description of person
    var title:String = ""
    
    // format
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(name)
                    .font(thisFont(size: 17))
                Text(title)
                    .font(thisFont(size: 12)).foregroundColor(Color.gray)
            }
        }
        
    }
}
