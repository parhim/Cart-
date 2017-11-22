//
//  GameScene.swift
//  Cart!
//
//  Created by Semen Parhimchik on 2016-10-19.
//  Copyright © 2016 Parhim. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    var background:SKNode!
    var foreground:SKNode!
    var hud:SKNode!
    var cart:SKNode!
    var restartButton:SKNode!
    var obstacle:SKNode!
    var scaleFactor:CGFloat!
    var endOfGamePosition = 0
    var xAcceleration:CGFloat = 0.0
    var scoreLabel:SKLabelNode!
    var highScoreLabel:SKLabelNode!
    var gameOverLabel:SKLabelNode!
    var playerMaxX:Int!
    var isGameOver = false
    var highScore:Int!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size:CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        scaleFactor = self.size.width / 320
        
        background = createBackgroud()
        addChild(background)
        
        foreground = SKNode()
        addChild(foreground)
        
        cart = createCart()
        foreground.addChild(cart)
        createObstacles()
        for i in 0...40{
        foreground.addChild(createUpperObstacles(n: i))
        
        }
 
        
        createHUD()
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        physicsWorld.contactDelegate = self
        
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var otherNode:SKNode!
        if contact.bodyA.node != cart{
            otherNode = contact.bodyA.node
        } else {
            otherNode = contact.bodyB.node
        }
        otherNode.action(forKey: .init())
        
    }
    
    func createHUD(){
        hud = SKNode()
        addChild(hud)
        
        restartButton = SKSpriteNode(imageNamed:"restart")
        restartButton.position.y = -100
        
        scoreLabel = SKLabelNode(fontNamed: "Futura-CondensedMedium")
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = SKColor.black
        scoreLabel.position = CGPoint(x: self.size.width * (9/10), y: self.size.height * (8/9))
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        highScoreLabel = SKLabelNode(fontNamed: "Futura-CondensedMedium")
        highScoreLabel.fontSize = 25
        highScoreLabel.fontColor = SKColor.black
        highScoreLabel.position = CGPoint(x: self.size.width * (1/20), y: self.size.height * (8/9))
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        highScoreLabel.text = "high score: \(GameHandler.sharedInstance.score)"
        gameOverLabel = SKLabelNode(fontNamed: "GillSans-UltraBold")
        gameOverLabel.fontSize = 45
        gameOverLabel.fontColor = SKColor.green
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.position = CGPoint.init(x: self.size.width/2, y: -200)
        hud.addChild(scoreLabel)
        hud.addChild(highScoreLabel)
        hud.addChild(restartButton)
        hud.addChild(gameOverLabel)
        
    }
    
    func gameOverScreen(){
        cart.physicsBody?.velocity.dy = 0
        cart.physicsBody?.velocity.dx = 0
        cart.physicsBody?.isDynamic = false
        if (GameHandler.sharedInstance.score>GameHandler.sharedInstance.highScore){
            GameHandler.sharedInstance.highScore = GameHandler.sharedInstance.score
        }
        highScoreLabel.text = "high score: \(GameHandler.sharedInstance.highScore)"
        gameOverLabel.position = CGPoint.init(x: self.size.width/2, y: 2*self.size.height/3)
        restartButton.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
       
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            var location:CGPoint!
            location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if (isGameOver){
                if restartButton.contains(location) {
                    newGame()
                }
            }
        }
    }
    
    func newGame(){
        isGameOver = false
        gameOverLabel.position.y = -200
        restartButton.position.y = -100
        
        cart.position = CGPoint(x: 201, y: 80)
        foreground.position = CGPoint(x:  -(cart.position.x - 180), y:0)
        background.position = CGPoint(x:  -(cart.position.x - 180), y:0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((cart.physicsBody?.velocity.dx.isZero)!) {
            cart.physicsBody?.isDynamic = true
            cart.physicsBody?.affectedByGravity = true
            cart.physicsBody?.mass = 1
            cart.physicsBody?.applyImpulse(CGVector.init(dx: 340, dy: 0))
            
        } else {
            cart.physicsBody?.applyImpulse(CGVector.init(dx: 0, dy: 700))
        }
    }
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        if((!(cart.physicsBody?.velocity.dx.isLess(than: 0))!) && !isGameOver){
            
            if cart.position.x > 200 {
                background.position = CGPoint(x: -(cart.position.x - 200), y: 0)
                foreground.position = CGPoint(x:  -(cart.position.x - 200), y:0)
                GameHandler.sharedInstance.score = Int(cart.position.x)/10
                scoreLabel.text = "\(GameHandler.sharedInstance.score)"
                
            }
            
            if (cart.position.y > self.size.height){
                cart.physicsBody?.velocity.dy = -(50)
            }
            
            if (cart.position.y < 82 && (cart.physicsBody?.velocity.dy)! < CGFloat(0)) {
                cart.position.y = 80
                cart.physicsBody?.velocity.dy = 0
                cart.physicsBody?.affectedByGravity = false
            } else { cart.physicsBody?.affectedByGravity = true}
        } else {
            isGameOver = true
            
            gameOverScreen()
        }
    }
}
