//  Eventend
//
//  Created by Stephen Boussarov on 6/19/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

class ViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var page: String = "groups" {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var curGroup: String = "" {
        didSet {
            objectWillChange.send(self)
        }
    }
}


struct ContentView: View {
    
    public static var hide = false
    
    @ObservedObject var viewRouter: ViewRouter = ViewRouter()
    
    public var fontName = "Helvetica"
    
    init() {
        // Sets tab bar color
        UITabBar.appearance().barTintColor = UIColor(named: "primary")
        
        // Sets list header color
        UITableViewHeaderFooterView.appearance().tintColor = UIColor(named: "secondary")
        
        // Removes top borders on form
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = UIColor(named: "clear")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "clear")
        
        UITabBar.appearance().isHidden = ContentView.hide
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)

        
        
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
                UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                currentPage = true
        } else {
            currentPage = false
        }
    }
        
    var currentPage: Bool
    
    @State var showTut = true
    
    @State var firstTut = true
    
    
    var body: some View {
        
        VStack {
            if self.viewRouter.page == "groups" {
                ZStack{
                    ColorManager.secondary
                        .edgesIgnoringSafeArea(.all)

                    GroupsView(viewRouter: viewRouter)
                    
                    // Redo Tutorial Button
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showTut = true
                                self.firstTut = false
                            }) {
                                Text("View Tutorial")
                                    .foregroundColor(Color.white)
                                    .font(thisFont(size: 20))
                                    .opacity(0.6)
                                    
                            }
                            
                            Spacer()
                        }

                    }
                    
                    // Tutorial
                    if (self.firstTut && self.currentPage) || (!self.firstTut && self.showTut) {
                        Rectangle()
                            .edgesIgnoringSafeArea(.vertical)
                            .opacity(0.5)
                        NewUser(showTut: self.$showTut, firstTut: self.$firstTut)
                    }
                    
                }
            } else if self.viewRouter.page == "tabs" {
                TabsView(viewRouter:  viewRouter)
            }
        }.font(Font.custom(fontName, size: 21))
    }
}


struct GroupsView: View {
    @ObservedObject var viewRouter: ViewRouter
    @FetchRequest(fetchRequest: Group.getAllGroups()) var groups:FetchedResults<Group>
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>
    @FetchRequest(fetchRequest: ThisEvent.getAllEvents()) var events:FetchedResults<ThisEvent>
    @FetchRequest(fetchRequest: ThisEventPerson.getAllEventPersons()) var eventPersons:FetchedResults<ThisEventPerson>
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var showView = false
    
    var body: some View {

            ZStack {
                VStack {
                    Rectangle()
                        .frame(height: CGFloat(100))
                        .foregroundColor(ColorManager.primary)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
                
                VStack {
                    Rectangle()
                        .frame(height: CGFloat(127))
                        .foregroundColor(ColorManager.primary)
                    Spacer()
                }

    
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        Text("Groups").font(Font.custom("Futura", size: 18)).foregroundColor(Color.white)
                            .padding(.leading,10)
                        
                        Spacer()
                        
                        Button(action: {
                            self.showView.toggle()
                        }) {
                            Image(systemName: "info.circle.fill").foregroundColor(.white).padding(.trailing)
                        }
                    }.padding(.top,100)
                    
                    
                    
                    List {
                        ForEach (self.groups) { group in
                            HStack {
                                
                                Button(action: {
                                    self.viewRouter.page = "tabs"
                                    self.viewRouter.curGroup = group.name!
                                }) {
                                    Text("\(group.name!)").font(thisFont(size: 25)).padding(.leading,10)
                                    }
                                .frame(width:320,alignment: .leading).padding(.vertical,8)
                                
                                
                                Image(systemName: "chevron.right").frame(alignment: .trailing).foregroundColor(Color.gray).padding(.trailing,10)
                                
                            }
                                    .background(Color.white).cornerRadius(5).foregroundColor(ColorManager.primary)
                                    .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
                        }
                        // on deletion of name
                        .onDelete { indexSet in
                            let deleteItem = self.groups[indexSet.first!]
                            
                            // deletes all corresponding persons in group
                            for person in self.persons {
                                if person.groupName! == deleteItem.name! {
                                    self.managedObjectContext.delete(person)
                                }
                            }
                            
                            // deletes all corresponding lists in group
                            for list in self.lists {
                                if list.groupName! == deleteItem.name! {
                                    self.managedObjectContext.delete(list)
                                }
                            }
                            
                            // deletes all corresponding events and eventPersons in group
                            for event in self.events {
                                if event.groupName! == deleteItem.name! {
                                    for person in self.eventPersons {
                                        if person.eventID == event.eventID {
                                            self.managedObjectContext.delete(person)
                                        }
                                    }
                                    self.managedObjectContext.delete(event)
                                }
                            }
                            
                            self.managedObjectContext.delete(deleteItem)
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }
                    } // end List
                        
                
                    // Removed App Description
                    HStack {
                        Spacer()
                        VStack {
                            Text("")
                        }
                        Spacer()
                    }
                } // end VStack
                
                VStack{
                    Text("Turnout Tracker").font(.custom("Futura Bold", size: 40)).padding(.top,25)
                    Spacer()
                }.foregroundColor(Color.white)
                
                AddButtonGroupView()
                
                if showView {
                    Rectangle()
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.vertical)
                        .onTapGesture {
                            self.showView = false
                        }
                    InfoButtonGroupsView(showPopUp: $showView)
                }
            } // end ZStack

    }
}



struct TabsView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    // var determining which tab is showing
    @State private var selection = 1
    
    
    
    var body: some View {
        
                
        // creates Tabs
        TabView(selection: $selection) {
            
            // first tab
            HomeTabView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName: "house.fill").imageScale(.large)
                    Text("Home")
            }.tag(1)
            
            // second tab
            MainEventsTabView(viewRouter: viewRouter)
                .tabItem {
                    
                    Image(systemName: "calendar").imageScale(.large)
                    Text("Events")
                    
        
            }.tag(2)
        
            
            // third tab
            MyListsTabView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName:"book.fill").imageScale(.large)
                    Text("Lists")
                }.tag(3)

        
            
        } /* end TabView */
        .accentColor(Color.white)
        .navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
        .onDisappear(perform: {
         self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
        })
    }
}
