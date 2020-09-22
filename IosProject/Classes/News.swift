//
//  News.swift
//  IosProject
//
//  Created by IlyesTourki on 6/25/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import Foundation
class News{
    var title : String
    var author: String
    var image: String
    var linksafari : String
    
    init(title:String,author:String , image:String, linksafari:String ) {
        self.title = title
        self.author = author
        self.image = image
        self.linksafari = linksafari
    }
}
