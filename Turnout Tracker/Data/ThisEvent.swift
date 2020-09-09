//
//  ThisEvent.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/7/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import CoreData

public class ThisEvent:NSManagedObject, Identifiable {
    // the name of this event
    @NSManaged public var name:String?
    // the name of corresponding list
    @NSManaged public var thisList:String?
    // the date of the event
    @NSManaged public var date:Date?
    // the unique ID of this event
    @NSManaged public var eventID:Int
    // name of group apart of
    @NSManaged public var groupName:String?
}

extension ThisEvent {
    static func getAllEvents() -> NSFetchRequest<ThisEvent> {
        let request:NSFetchRequest<ThisEvent> = ThisEvent.fetchRequest() as! NSFetchRequest<ThisEvent>
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
