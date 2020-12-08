//
//  EnemyController.swift
//  game789
//
//  Created by Harrison Fedor on 6/7/18.
//  Copyright © 2018 Harrison Fedor. All rights reserved.
//

import SpriteKit

class EnemyController {
    
    struct ColliderType {
        static let Player: UInt32 = 0
        static let Enemy: UInt32 = 1
    }
    
    func spawnEnemy() -> SKSpriteNode {
        let item : SKSpriteNode?
        item = SKSpriteNode(imageNamed: "NewSeven")
        item!.name = "Seven"
        item!.setScale(0.5)
        item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2.5)
        item!.physicsBody?.categoryBitMask = ColliderType.Enemy
        item!.size.height = 55
        item!.size.width = 55
        item!.zPosition = 3
        item!.anchorPoint = CGPoint(x: 0.5,y:  0.5)
        let x = randomBetweenNumbers(firstNum: 1, secondNum: 2)
        if (x <= 1.5){
            item!.position.x = -220
        }
        else{
            item!.position.x = 220
        }
        item!.position.y = -380
        item!.physicsBody?.affectedByGravity = false
        item!.physicsBody?.restitution = 1
        item!.physicsBody?.friction = 0.01
        item!.physicsBody?.linearDamping = 0
        item!.physicsBody?.angularDamping = 0
        item!.physicsBody?.isDynamic = true
        item!.physicsBody?.velocity = CGVector.init(dx: randomBetweenNumbers(firstNum: 200, secondNum: 300), dy: randomBetweenNumbers(firstNum: 200, secondNum: 300))
        
        return item!
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
