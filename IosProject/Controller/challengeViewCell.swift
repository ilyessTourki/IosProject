//
//  challengeViewCell.swift
//  IosProject
//
//  Created by IlyesTourki on 5/1/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class challengeViewCell: UITableViewCell {

    @IBOutlet weak var Titre: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setChallenge(challenge : Chalenge){
        Titre.text = challenge.titre
        date.text = challenge.date
    }

}
