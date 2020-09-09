//
//  Person.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/19/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import CoreData

public class Person:NSManagedObject, Identifiable {
    // name of person
    @NSManaged public var name:String?
    // title or description of person
    @NSManaged public var title:String?
    // in which list
    @NSManaged public var listName:String?
    // corresponding listID
    @NSManaged public var listID:Int
    // name of group this person is in
    @NSManaged public var groupName:String?
}

extension Person {
    static func getAllPersons() -> NSFetchRequest<Person> {
        let request:NSFetchRequest<Person> = Person.fetchRequest() as! NSFetchRequest<Person>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
