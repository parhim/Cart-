//
//  GameElements.swift
//  Cart!
//
//  Created by Semen Parhimchik on 2016-10-19.
//  Copyright © 2016 Parhim. All rights reserved.
//
import Foundation
import SpriteKit

extension GameScene{
    func createBackgroud() -> SKNode{
        let backgroundNode = SKNode()
        let spacing = 667 * scaleFactor/2
        
        
        for lap in 0...50{
        for index in 0...1{
            let node = SKSpriteNode(imageNamed: String(format: "bg%0d",index+1))
            node.setScale(scaleFactor/2)
            node.anchorPoint = CGPoint(x: 0,y:0.5)
            node.position = CGPoint(x: spacing*CGFloat(index+(2*lap)), y: self.size.height/2)
            backgroundNode.addChild(node)
            }}
        
        
        
        return backgroundNode
        
    }
    

    
    func createCart()->SKNode{
        let playerNode = SKNode();
        playerNode.position = CGPoint(x: 201, y: 80)
        
        let sprite = SKSpriteNode(imageNamed: "cart")
        playerNode.addChild(sprite)
        
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.height/2)
        
        //gravity
        playerNode.physicsBody?.isDynamic = false
        
        playerNode.physicsBody?.allowsRotation = false
        playerNode.physicsBody?.restitution = 1
        playerNode.physicsBody?.friction = 0
        playerNode.physicsBody?.angularDamping = 0
        playerNode.physicsBody?.linearDamping = 0
        playerNode.physicsBody?.usesPreciseCollisionDetection = false
       
        
        return playerNode
    }
    
    func createObstacles(){
        for i in 0...40{
            let obsNode = Obstacle()
            obsNode.obstacleType = ObstacleType.stock
            obsNode.position = CGPoint(x:800 + (i * 350),y:80)
            let sprite = SKSpriteNode(imageNamed: "obst1")
            obsNode.addChild(sprite)
            obsNode.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            obsNode.physicsBody?.isDynamic = false
            obsNode.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
            obsNode.physicsBody?.collisionBitMask = CollisionBitMask.Obstacle
            foreground.addChild(obsNode)
            if (i%2==1) {
                let an = Obstacle()
                an.obstacleType = ObstacleType.stock
                an.position = CGPoint(x:800 + (i * 350),y:150)
                let sprite = SKSpriteNode(imageNamed: "obst1")
                an.addChild(sprite)
                an.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
                an.physicsBody?.isDynamic = false
                an.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
                an.physicsBody?.collisionBitMask = CollisionBitMask.Obstacle
                foreground.addChild(an)
            }
        }
    }

    func createUpperObstacles(n:Int)->Obstacle{
        let obsNode = Obstacle()
        if (n%2==0) {
            obsNode.obstacleType = ObstacleType.stock
            obsNode.position = CGPoint(x:800 + (n * 350),y:350)
            let sprite = SKSpriteNode(imageNamed: "obst1")
            obsNode.addChild(sprite)
            obsNode.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            obsNode.physicsBody?.isDynamic = false
            obsNode.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
            obsNode.physicsBody?.collisionBitMask = CollisionBitMask.Obstacle
        }
        return obsNode
    }
    

    
    
    
}
