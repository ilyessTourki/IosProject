//
//  Challenge.swift
//  IosProject
//
//  Created by IlyesTourki on 5/1/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import Foundation
class Chalenge{
    var id : String
    var titre: String
    var date: String
    var description : String
    
    init(id:String,titre:String , date:String , description:String) {
        self.id = id
        self.titre = titre
        self.date = date
        self.description = description
    }
}
