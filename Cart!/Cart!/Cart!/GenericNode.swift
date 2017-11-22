//
//  GenericNode.swift
//  Cart!
//
//  Created by Semen Parhimchik on 2017-01-23.
//  Copyright © 2017 Parhim. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Obstacle:UInt32 = 0x01
    
}

enum ObstacleType:Int{
    case stock = 0
    case future = 1///add obstacle types here
}

class GenericNode: SKNode {
    
    func collisionWithPlayer(_ player:SKNode)->Bool{
        
        return false
    }
    
    func shouldRemoveNode(_ playerY:CGFloat){
        if playerY > self.position.x + 300{
            self.removeFromParent()
        }
        
    }
}
