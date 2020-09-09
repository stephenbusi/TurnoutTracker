//
//  MyListsTabView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/19/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI



struct MyListsTabView: View {
    
    @Environment(\.managedObjectContext) public var managedObjectContext
    @FetchRequest(fetchRequest: ThisList.getAllLists()) public var lists:FetchedResults<ThisList>
    @FetchRequest(fetchRequest: Person.getAllPersons()) public var persons:FetchedResults<Person>
    
    @ObservedObject var viewRouter: ViewRouter


    @State private var showingAlert = false
    
    @State private var newListName = ""
    
    @State var showView = false

    var body: some View {
        NavigationView {
            ZStack {
                
                // Background Image
                Image(systemName: "book").resizable()
                    .allowsHitTesting(false).frame(width: 300.0, height: 300.0).opacity(0.5)
                .foregroundColor(ColorManager.primary)
                .position(x: 50, y: 500)
                .opacity(0.1)

                VStack {
                    List {
                        if(lists.count != 0) {
                            //List of People in List
                            ForEach(self.lists) { thisList in
                                if(thisList.groupName! == self.viewRouter.curGroup) {
                                    HStack{
                                        Text(thisList.name!)
                                            .font(thisFont(size: 18))
                                            .listRowBackground(ColorManager.clear)
                                        
                                        NavigationLink("", destination: ThisListView(viewRouter: self.viewRouter, listID: thisList.listID).environment(\.managedObjectContext, self.managedObjectContext))
                                        
                                    }.listRowBackground(Color.white.opacity(0.0))
                                }
                            }
                            // on deletion of name
                            .onDelete { indexSet in
                                let deleteItem = self.lists[indexSet.first!]
                                
                                // deletes all corresponding names in list
                                for person in self.persons {
                                    if person.listID == deleteItem.listID {
                                        self.managedObjectContext.delete(person)
                                    }
                                }
                                
                                
                                self.managedObjectContext.delete(deleteItem)
                                
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                            }
                            
                        } else {
                            Text("Lists will appear here").foregroundColor(Color.gray).font(.caption)
                        }
                        
                    } // end List
                        .padding(.top)
                        .navigationBarTitle(Text("Lists"), displayMode: .inline)
                        .navigationBarItems(leading: GroupsBackButton(viewRouter: viewRouter), trailing:
                            Button(action: {
                                self.showView.toggle()
                            }) {
                                Image(systemName: "info.circle.fill").foregroundColor(.white)
                            })
                        .navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
                    
                    // app description
                    AppDescription()
                } // end VStack
                  
                AddButtonListView(viewRouter: viewRouter)
                
                
                if showView {
                    Rectangle()
                        .opacity(0.3)
                        .onTapGesture {
                            self.showView = false
                        }
                    InfoButtonListsView(showPopUp: $showView)

                }
            } // end ZStack
        } // end NavView
    }
}
