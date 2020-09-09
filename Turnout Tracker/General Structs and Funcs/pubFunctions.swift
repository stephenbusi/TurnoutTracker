//
//  pubFunctions.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import SwiftUI

/*
 Description: Determines top-right button title and action
     (if newly created List/Event, creates Done button
     else, edit button)
 Parameters: bool - determines which button to create
 */
func topButton(bool: Bool) -> some View {
    // if new List/Event
    if bool {
        return AnyView(Button("Done", action: {
            UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
        }))
    }
    
    return AnyView(Text(""))
}

/*
 Description: Sets format of date String
 */
public var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, MM/dd/yy hh:mm a"
    return formatter
}()

public var dateFormatterSlash: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"
    return formatter
}()

/*
 Description: copies names in one list to another
 Parameters: fromID - ID of list that is copied from
             to - name of list copied to
             toID - ID of list that is copied to
             persons - list of all Person objects
 */
public func copyList(fromID: Int, to: String, toID: Int, persons: FetchedResults<Person>) {
    // gets context of data
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // loops through all persons and copies proper ones
    for person in persons {
        if person.listID == fromID {
            // creates new person
            let newPerson = Person(context: manageObjectContext)
            // sets new person data
            newPerson.name = person.name
            newPerson.title = person.title
            newPerson.listName = to
            newPerson.listID = toID
            newPerson.groupName = person.groupName
        }
    }
}

struct AppDescription: View {
    
    var body: some View {
        HStack {
            Spacer()
            Text("Turnout Tracker V1.0").foregroundColor(ColorManager.primary).font(.caption).opacity(0.75)
            Spacer()
        }
    }
}

public func thisFont(size: CGFloat) -> Font{
    return Font.custom("Helvetica", size: size)
}
