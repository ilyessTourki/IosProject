//
//  ContainerController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/16/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    var menucontroller : UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func configureMebuController(){
        if menucontroller == nil{
            menucontroller = MenuController()
            view.insertSubview(menucontroller.view, at: 0)
            addChild(menucontroller)
            menucontroller.didMove(toParent:self)
            print("ayy haja ")
            
        }
    }
}
/*extension ContainerController:HomeControllerDelegate{
    func handlemenuToggle() {
         print("okk")
        configureMebuController()
    }
}*/
