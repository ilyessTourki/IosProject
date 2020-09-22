//
//  RankTableViewCell.swift
//  IosProject
//
//  Created by IlyesTourki on 6/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var medal: UIImageView!
    
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var name: UILabel!
    
       func setRanks(user : User){
           name.text = user.name
           points.text = user.point
        medal.image = nil
       }
    
}
