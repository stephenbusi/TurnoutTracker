//
//  ViewRouter.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 9/8/20.
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
