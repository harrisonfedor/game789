//
//  MenuController.swift
//  game789
//
//  Created by Harrison Fedor on 6/4/18.
//  Copyright © 2018 Harrison Fedor. All rights reserved.
//

import SpriteKit

class MenuController: SKScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start" {
                if let scene = GameController(fileNamed: "GameplayScene") {
                scene.scaleMode = .aspectFill
                view!.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                }
            }
            else if atPoint(location).name == "Exit" {
                exit(0)
            }
        }
    }
}
