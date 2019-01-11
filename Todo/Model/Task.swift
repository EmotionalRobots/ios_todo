//
//  Task.swift
//  Todo
//
//  Created by Chris Anderson on 1/11/19.
//  Copyright © 2019 Chris Anderson. All rights reserved.
//

import Foundation

class Task: Codable{
    
    var title: String
    var done: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
}
