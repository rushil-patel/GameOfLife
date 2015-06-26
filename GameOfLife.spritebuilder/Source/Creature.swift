//
//  Creature.swift
//  GameOfLife
//
//  Created by Rushil Patel on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Creature: CCSprite {
    
    //property observer
    //when the creature is set to be alive it will become visible , vice versa
    var isAlive = false {
        didSet {
            self.visible = isAlive
        }
        
    }
    var livingNeighborCount = 0
    
    convenience override init() {
        
        //set image of creature to bubble.png
        self.init(imageNamed: "GameOfLifeAssets/Assets/bubble.png")
        anchorPoint = CGPoint(x: 0, y: 0)
        
        
    }
    
    
   
}
