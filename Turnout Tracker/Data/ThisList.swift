//
//  ThisList.swift
//  Eventend
//
//  Created by Stephen Boussarov on 6/20/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import Foundation
import CoreData

public class ThisList:NSManagedObject, Identifiable {
    // the name of this list
    @NSManaged public var name:String?
    // the name of this list's group
    @NSManaged public var groupName:String?
    // the unique ID of this list
    @NSManaged public var listID:Int
}

extension ThisList {
    static func getAllLists() -> NSFetchRequest<ThisList> {
        let request:NSFetchRequest<ThisList> = ThisList.fetchRequest() as! NSFetchRequest<ThisList>
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
