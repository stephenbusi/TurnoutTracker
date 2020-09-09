//
//  HomeTabView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var persons:FetchedResults<ThisEventPerson>

    @ObservedObject var viewRouter: ViewRouter
    
    @State var showView = false
    
    public var unique: [ThisEventPerson] {
        var returnVal = [ThisEventPerson]()
        var uniqueName = [String]()
        
        for person in persons {
            if person.groupName! == self.viewRouter.curGroup {
                if !uniqueName.contains(person.name!) {
                    returnVal.append(person)
                    uniqueName.append(person.name!)
                }
            }
        }
        
        return returnVal
    }

    
    var body: some View {
            
            
        NavigationView {
            
            ZStack {
                
                // Background Image
                Image(systemName: "house.fill").resizable()
                    .frame(width: 300.0, height: 300.0).opacity(0.5)
                .foregroundColor(ColorManager.primary)
                .position(x: 50, y: 500)
                .opacity(0.1)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        
                        // Title
                        HStack {
                            Text("\(self.viewRouter.curGroup)")
                                .font(.custom("Futura Bold", size: 28))
                                .multilineTextAlignment(.leading).frame(alignment: .leading)
                            
                            EditButtonGroupView(viewRouter: viewRouter, thisGroup: self.viewRouter.curGroup).padding(.bottom,12)
                        }
                        .frame(width: 350, alignment: .leading).padding(.horizontal).padding(.top,40)
                        .padding(.bottom)
                        
                        // Stats
                        NavigationLink("Group Statistics", destination: GroupStatsView(viewRouter: viewRouter)).foregroundColor(ColorManager.primary).padding(.horizontal).padding(.bottom)
                    }
                    
                    List {
                        
                        Section(header:
                            Text("Attendee Statistics:")
                                .foregroundColor(Color.white).font(thisFont(size: 18))
                                .fontWeight(.semibold)) {
                            if(unique.count != 0) {
                                ForEach (unique) { person in
                                    
                                        
                                    NavigationLink(destination: PersonStatsView(viewRouter: self.viewRouter, person: person.name!)) {
                                        
                                        Text("\(person.name!)").font(Font.custom("Helvetica", size: 20)).frame(width: 200, alignment: .leading).onAppear()
                                                
                                    }
                                }
                                // on deletion of name
                                .onDelete { indexSet in
                                    let deleteItem = self.persons[indexSet.first!]
                                    
                                    self.managedObjectContext.delete(deleteItem)
                                    
                                    do {
                                        try self.managedObjectContext.save()
                                    } catch {
                                        print(error)
                                    }
                                }
                            } else {
                                Text("Attendees within all events will appear here").foregroundColor(Color.gray).font(.caption)
                            }
                        } // end Section 2
                        
                    } // end list
                    
                    // App Description
                    AppDescription()
                    
                } // end VStack
                    .navigationBarTitle("Home", displayMode: .inline)
                    .navigationBarItems(leading: GroupsBackButton(viewRouter: viewRouter), trailing:
                        Button(action: {
                            self.showView.toggle()
                        }) {
                            Image(systemName: "info.circle.fill").foregroundColor(.white)
                        })
                    .navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                
                
                if showView {
                    Rectangle()
                        .opacity(0.3)
                        .onTapGesture {
                            self.showView = false
                        }

                    InfoButtonHomeView(showPopUp: $showView)

                }
            } // end ZStack
        } // end NavView
    }
}
