//
//  Work.swift
//  TodoList
//
//  Created by Luong Quang Huy on 3/19/20.
//  Copyright © 2020 Luong Quang Huy. All rights reserved.
//

import Foundation
class Awork{
    var content: String?
    var date: Date?
    var workId: String
    
    func isToDay() -> Bool{
        let now = Date()
        if now.compare(self.date!) == .orderedAscending{
            return true
        }else{
            return false
        }
    }
    
    func isOutTime() -> Bool{
        let now = Date()
        if now.compare(self.date!) == .orderedDescending{
            return true
        }else{
            return false
            
        }
    }
    
    init(content: String?, date: Date?, workId: String){
        self.content = content
        self.date = date
        self.workId = workId
    }
}
