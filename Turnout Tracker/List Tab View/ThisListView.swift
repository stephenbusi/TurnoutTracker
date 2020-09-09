//
//  ThisListView.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/21/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct ThisListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Person.getAllPersons()) var persons:FetchedResults<Person>
    @FetchRequest(fetchRequest: ThisList.getAllLists()) var lists:FetchedResults<ThisList>
    
    @ObservedObject var viewRouter: ViewRouter
    
    @State private var newPersonName = ""
    @State private var newPersonTitle = ""
    
    var thisList: ThisList {
        for list in lists {
            if list.listID == listID {
                return list
            }
        }
        return lists[0]
    }
    
    @State var newList = false
    @State var listID = 0
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Title
            HStack {
                Text(thisList.name!).font(.custom("Futura Bold", size: 28))
                EditButtonListView(viewRouter: viewRouter, thisListID: listID).padding(.bottom,12)
            }.frame(width: 350, alignment: .leading).padding(.leading, 18).padding(.top)
            
            List {
                // First Section: Adding new person
                Section(header:
                    Text("Add New Person:")
                        .foregroundColor(Color.white).font(thisFont(size: 18))
                        .fontWeight(.semibold)
                ){
                    
                    HStack {
                        HStack {
                            TextField("Name", text: self.$newPersonName).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical).accentColor(.gray)
                            TextField("Description", text: self.$newPersonTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding(.vertical).accentColor(.gray)
                        }
                        Button(action: {
                            // if name input is filled
                            if self.newPersonName != "" {
                                // assign new person
                                let person = Person(context: self.managedObjectContext)
                                person.title = self.newPersonTitle
                                person.name = self.newPersonName
                                person.listName = self.thisList.name!
                                person.listID = self.listID
                                person.groupName = self.viewRouter.curGroup
                                
                                // try to save
                                do {
                                    try self.managedObjectContext.save()
                                } catch {
                                    print(error)
                                }
                            }
                            
                            // clear input field
                            self.newPersonTitle = ""
                            self.newPersonName = ""
                            // removes keyboard
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                        }) {
                            Image(systemName: "plus.circle.fill").foregroundColor(ColorManager.primary)
                                .imageScale(.large)
                        }
                        
                    }
                }.font(.headline)
                
                // Second Section: List of People in List
                Section(header:
                    Text("List of People:")
                        .foregroundColor(Color.white).font(thisFont(size: 18))
                        .fontWeight(.semibold)
                ){
                    ForEach(self.persons) { person in
                        if person.listID == self.listID {
                            if person.listName! == self.thisList.name! {
                                PersonView(name: person.name!,title: person.title!)
                            }
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
                }
            } // end List
                .navigationBarTitle(Text(thisList.name!))
            .navigationBarItems(trailing: topButton(bool: newList).foregroundColor(ColorManager.primary))
            .navigationBarColor(backgroundColor: UIColor.white,textColor: UIColor.black)
        } // end VStack
            .navigationBarBackButtonHidden(self.newList)
            .onDisappear(perform: {
                self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
            })


    }
}
