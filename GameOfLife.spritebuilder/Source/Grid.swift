//
//  Grid.swift
//  Chipmunk7-ios
//
//  Created by Rushil Patel on 6/26/15.
//
//

import UIKit

let GridRows = 8
let GridCols = 10

class Grid: CCSprite {
    
    var totalAlive = 0
    var generation = 0
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    var gridArray: [[Creature]]!
    
    
    //method to activate touch handling on the grid
    override func onEnter() {
        
        super.onEnter()
        
        setupGrid()
        
        userInteractionEnabled = true
    }

    func setupGrid() {
        cellWidth = contentSize.width / CGFloat(GridCols)
        cellHeight = contentSize.height / CGFloat(GridRows)
        
        gridArray = []
        
        
        for row in 0..<GridRows {
            //initialize inner array
            gridArray.append([])
            
            for col in 0..<GridCols {
                var creature = Creature()
                
                creature.position = CGPoint(x: cellWidth * CGFloat(col), y: cellHeight * CGFloat(row))
                
                //strong reference
                //add creature reference to GRID CCNODE
                self.addChild(creature)
                //add creature reference to GRID array
                gridArray[row].append(creature)
                
                creature.isAlive = false
                
            }
        }
    }
    
    func creatureForTouchPosition(touchPosition: CGPoint) -> Creature {
            
        var rowTouch = Int(touchPosition.y / cellHeight)
        var colTouch = Int(touchPosition.x / cellWidth)
            
        return gridArray[rowTouch][colTouch]
            
    }   
        
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchLocation = touch.locationInNode(self)
        
        var creature = creatureForTouchPosition(touchLocation)
        
        //toggle isAlive boolean
        creature.isAlive = !creature.isAlive
    }
    
    func evolveStep () {
        countNeighbors()
        updateCreatures()
        generation++
    }
    
    
    func countNeighbors() {
        for row in 0..<gridArray.count {
            for col in 0..<gridArray[row].count {
                
                var currentCreature = gridArray[row][col]
                currentCreature.livingNeighborCount = 0
                
                for x in (row - 1)...(row + 1) {
                    for y in (col - 1)...(col + 1) {
                        var validIndex = isValidIndex(x: x, y: y)
                        if validIndex && !(x == row && y == col) {
                            var neigbhor = gridArray[x][y]
                            
                            if neigbhor.isAlive {
                                currentCreature.livingNeighborCount++
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isValidIndex(#x: Int, y: Int) -> Bool {
        return !(x < 0 || y < 0 || x >= GridRows || y >= GridCols)
    }
    
    func updateCreatures() {
        
        totalAlive = 0
        
        for row in 0..<gridArray.count {
            for col in 0..<gridArray[row].count {
                var currentCreature = gridArray[row][col]
                
                switch currentCreature.livingNeighborCount {
                case 3:
                    currentCreature.isAlive = true
                case let overPopulated where currentCreature.livingNeighborCount > 3:
                    currentCreature.isAlive = false
                case let underPopulated where currentCreature.livingNeighborCount < 2:
                    currentCreature.isAlive = false
                default:
                    break
                    
                }
                
                if currentCreature.isAlive {
                    totalAlive++
                }
                
            }
        }
    
    }





}
