//
//  GameController.swift
//  game789
//
//  Created by Harrison Fedor on 6/4/18.
//  Copyright © 2018 Harrison Fedor. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameController: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player?
    private var location = CGPoint()
    private var enemyController = EnemyController()
    private var score = 0
    private var scoreLabel: SKLabelNode?
    private var goodAudioPlayer: AVAudioPlayer?
    private var badAudioPlayer:  AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
       player?.move(point: location)
       score += 1
       scoreLabel?.text = String(score)
    }
    
    private func initializeGame(){
        physicsWorld.contactDelegate = self
        player = (childNode(withName: "Player") as? Player?)!
        player?.initializePlayer()
        spawnEnemy()
        Timer.scheduledTimer(timeInterval: TimeInterval(enemyController.randomBetweenNumbers(firstNum: 4, secondNum: 7)), target: self, selector: #selector(GameController.spawnEnemy), userInfo: nil, repeats: true)
        scoreLabel = (childNode(withName: "Score") as? SKLabelNode?)!

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Seven" {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(GameController.restartGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func spawnEnemy() {
        self.scene?.addChild(enemyController.spawnEnemy())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            location = touch.location(in: self)
            }
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                location = touch.location(in: self)
            }
        }

    @objc func restartGame() {
        scoreLabel?.fontSize = 125
        scoreLabel?.position.x = 0
        scoreLabel?.position.y = 0
        scoreLabel?.fontColor = .white
        let badURL = Bundle.main.url(forResource: "badScoreSound", withExtension: "mp3")
        let goodURL = Bundle.main.url(forResource: "goodScoreSound", withExtension: "mp3")
//        
        if (score < 1000) {
            do {
                badAudioPlayer = try AVAudioPlayer(contentsOf: badURL!)
                badAudioPlayer?.prepareToPlay()
                badAudioPlayer?.play()
            }
            catch{
            }
            if let view = self.view {
                if let scene = MenuController(fileNamed: "MenuScene") {
                    scene.scaleMode = .aspectFill
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 3))
                }
        }
        }
        else if (score >= 1000) {
                if let view = self.view {
                    if let scene = MenuController(fileNamed: "MenuScene") {
                        scene.scaleMode = .aspectFill
                        view.presentScene(scene, transition: SKTransition.fade(withDuration: 8))
                    }
                }
            do {
                goodAudioPlayer = try AVAudioPlayer(contentsOf: goodURL!)
                goodAudioPlayer?.prepareToPlay()
                goodAudioPlayer?.play()
            }
            catch {
            }
        }
    }
}
