//
//  ThisEventPerson.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/7/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import CoreData

public class ThisEventPerson:NSManagedObject, Identifiable {
    // name of person
    @NSManaged public var name:String?
    // title or description of person
    @NSManaged public var title:String?
    // in which event
    @NSManaged public var eventName:String?
    // if checked
    @NSManaged public var checked:Bool
    // the unique ID of this person's event
    @NSManaged public var eventID:Int
    // name of group this person is in
    @NSManaged public var groupName:String?
    // list used for this event person
    @NSManaged public var eventList:String?
    // date of event for this person
    @NSManaged public var eventDate:Date?
}


extension ThisEventPerson {
    static func getAllEventPersons() -> NSFetchRequest<ThisEventPerson> {
        let request:NSFetchRequest<ThisEventPerson> = ThisEventPerson.fetchRequest() as! NSFetchRequest<ThisEventPerson>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
