//
//  Group.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import CoreData

public class Group:NSManagedObject, Identifiable {
    // name of group
    @NSManaged public var name:String?
}

extension Group {
    static func getAllGroups() -> NSFetchRequest<Group> {
        let request:NSFetchRequest<Group> = Group.fetchRequest() as! NSFetchRequest<Group>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
