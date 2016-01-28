//
//  GameScene.swift
//  flappybird
//
//  Created by surrus on 1/27/16.
//  Copyright (c) 2016 surrus. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
    var bird = SKSpriteNode()
  
    override func didMoveToView(view: SKView) {
      
      // physics
      self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
      
      // bird
      var birdTexture = SKTexture(imageNamed: "flappybird")
      birdTexture.filteringMode = SKTextureFilteringMode.Nearest
      
      bird = SKSpriteNode(texture: birdTexture)
      bird.setScale(1)
      bird.position = CGPoint(x: self.frame.size.width * 0.35 ,y: self.frame.size.height * 0.6)
      
      bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/4)
      bird.physicsBody?.dynamic = true
      bird.physicsBody?.allowsRotation = false
      
      self.addChild(bird)
      
      // ground
      var groundTexture = SKTexture(imageNamed: "ground")
      
      var sprite = SKSpriteNode(texture: groundTexture)
      sprite.setScale(4.0)
      sprite.position = CGPoint(x: self.size.width/2, y: sprite.size.height/2)
      
      self.addChild(sprite)
      
      
      var ground = SKNode()
      ground.position = CGPointMake(0, groundTexture.size().height*2)
      ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 4.0))
      
      ground.physicsBody?.dynamic = false
      self.addChild(ground)
      
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
          let location = touch.locationInNode(self)
          
          bird.physicsBody?.velocity = CGVectorMake(0, 0)
          bird.physicsBody?.applyImpulse(CGVectorMake(0, 25))
      
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
