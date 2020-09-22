//
//  User.swift
//  IosProject
//
//  Created by IlyesTourki on 6/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import Foundation
class User{
    var id : String
    var name: String
    var point: String
   
    
    init(id:String,name:String , point:String ) {
        self.id = id
        self.name = name
        self.point = point
    }
}
