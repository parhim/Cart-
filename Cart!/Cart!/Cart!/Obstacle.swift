//
//  Obstacle.swift
//  Cart!
//
//  Created by Semen Parhimchik on 2017-01-23.
//  Copyright © 2017 Parhim. All rights reserved.
//

import SpriteKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}


class Obstacle: GenericNode {
    
    var obstacleType:ObstacleType!
    
    override func collisionWithPlayer(_ player: SKNode) -> Bool {
        player.physicsBody?.velocity.dx = 0
        player.physicsBody?.velocity.dy = 0
        player.physicsBody?.affectedByGravity = false
        return true
    }
    
}

