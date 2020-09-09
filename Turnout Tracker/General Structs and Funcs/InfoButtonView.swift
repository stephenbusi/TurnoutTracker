//
//  InfoButtonView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/23/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct InfoButtonGroupsView: View {
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Groups Page Information").bold()
                Spacer()
                Text("A group is a framework for an organization, club, or team. Events, lists, and statistics of each group are kept seperate.\n").frame(width:270, alignment: .leading)
                    .font(.footnote)
                
                Text("Add Group:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Tap the plus botton on the bottom-right\n").font(Font.footnote).frame(width:270, alignment: .leading)
            
                Text("Delete Group:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Swipe left on a group").font(Font.footnote).frame(width:270, alignment: .leading)
                
                    
                Spacer()
                Button(action: {
                    self.showPopUp = false
                }) {
                    Text("Okay!").foregroundColor(ColorManager.primary)
                }
            }.padding()
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct InfoButtonHomeView: View {
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Home Page Information").bold()
                Spacer()
                
                Text("The home page contains statistics pertaining to the current group, as well as a list of all attendees that have been included in any event. Tap on an attendee to see their relevant statistics.\n")
                    .font(.footnote)
                    .frame(width:270, alignment: .leading)
                
                Text("Edit Group:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Tap on the icon next to the group name\n").font(Font.footnote).frame(width:270, alignment: .leading)
                
                Text("Delete Attendee:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Swipe left on a attendee").font(Font.footnote).frame(width:270, alignment: .leading)
                
                Spacer()
                Button(action: {
                    self.showPopUp = false
                }) {
                    Text("Okay!").foregroundColor(ColorManager.primary)
                }
            }.padding()
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct InfoButtonEventsView: View {
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Events Page Information").bold()
                Spacer()
                
                Text("Events are sorted chronologically from nearest to furthest in time. 24 hours after an event has occured, it will be moved to past events.\n")
                    .font(.footnote).frame(width:270, alignment: .leading)
                
                Text("Add Event:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Tap the plus botton on the bottom-right\n").font(Font.footnote).frame(width:270, alignment: .leading)
                
                Text("Delete Event:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Swipe left on an event").font(Font.footnote).frame(width:270, alignment: .leading)
                Spacer()
                Button(action: {
                    self.showPopUp = false
                }) {
                    Text("Okay!").foregroundColor(ColorManager.primary)
                }
            }.padding()
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct InfoButtonListsView: View {
    @Binding var showPopUp: Bool
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Text("Lists Page Information").bold()
                Spacer()
                
                Text("The same list of people can be used for multiple events. This way, names do not have be re-typed for every event.\n")
                    .font(.footnote)
                    .frame(width:270, alignment: .leading)
                
                Text("Add List:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Tap the plus botton on the bottom-right\n").font(Font.footnote).frame(width:270, alignment: .leading)
                
                Text("Delete List:").font(Font.footnote.bold()).frame(width:270, alignment: .leading)
                Text("Swipe left on a list").font(Font.footnote).frame(width:270, alignment: .leading)
                
                Spacer()
                Button(action: {
                    self.showPopUp = false
                }) {
                    Text("Okay!").foregroundColor(ColorManager.primary)
                }
            }.padding()
        }
        .frame(width: 300, height: 275)
        .cornerRadius(20).shadow(radius: 20)
    }
}

