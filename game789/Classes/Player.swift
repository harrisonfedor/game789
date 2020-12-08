//
//  Player.swift
//  game789
//
//  Created by Harrison Fedor on 6/5/18.
//  Copyright © 2018 Harrison Fedor. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    func move(point:CGPoint) {
        if (point.x > -180 && point.x < 180 && point.y > -375 && point.y < 215){
        position = point
        }
    }
    
    func initializePlayer() {
        name = "Player"
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = EnemyController.ColliderType.Player
        physicsBody?.contactTestBitMask = EnemyController.ColliderType.Enemy
        
    }
}
