//
//  AddButton.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/17/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(ColorManager.primary)
                .frame(width: 50, height: 50)
                .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
            
            Text("+").foregroundColor(.white).bold().font(.system(size: 35)).padding(.bottom,5)
        }
    }
}
