//
//  GameHandler.swift
//  Cart!
//
//  Created by Semen Parhimchik on 2016-10-20.
//  Copyright © 2016 Parhim. All rights reserved.
//

import Foundation

class GameHandler {
    var score:Int
    var highScore:Int
    
    var levelData:NSDictionary!
    
    class var sharedInstance:GameHandler{
        struct Singleton{
            static let instance = GameHandler()
        }
        return Singleton.instance
    }
    
    init(){
        score = 0
        highScore = 0
    
        
        let userDefaulfts = UserDefaults.standard
        highScore = userDefaulfts.integer(forKey: "highScore")
       
    }
    
    func saveGameStats(){
        highScore = max(score, highScore)
        
        let userDefaulfts = UserDefaults.standard
        userDefaulfts.set(highScore, forKey: "highScore")
        userDefaulfts.synchronize()
    }
}
