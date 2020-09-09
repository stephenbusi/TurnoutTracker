//
//  CopyButtonsView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/20/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct CopyAttendedButtonView: View {
    var body: some View {
        
        ZStack {
            Rectangle()
            .fill(Color.white)
            .frame(width: 115, height: 30)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
            .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(ColorManager.primary, lineWidth: 1)
            )
            .opacity(0.9)

            HStack {
                Text("Copy Attended").foregroundColor(ColorManager.primary).font(thisFont(size: 12)).padding(.bottom,-1)
                Image(systemName: "doc.on.doc").imageScale(.small).foregroundColor(ColorManager.primary)
            }
        }
        
    }
}

struct CopyMissingButtonView: View {
    var body: some View {
        
        ZStack {

            Rectangle()
                .fill(Color.white)
                .frame(width: 115, height: 30)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
                .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(ColorManager.primary, lineWidth: 1)
                )
                .opacity(0.9)
            HStack {
                Text("Copy Absent   ").foregroundColor(ColorManager.primary).font(thisFont(size: 12)).padding(.bottom,-1)
                Image(systemName: "doc.on.doc").imageScale(.small).foregroundColor(ColorManager.primary)
            }
        }
    }
}

