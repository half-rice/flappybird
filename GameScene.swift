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
  var pipeUpTexture = SKTexture()
  var pipeDownTexture = SKTexture()
  var pipesMoveAndRemove = SKAction()
  
  let pipeGap = 150.0
  
  override func didMoveToView(view: SKView) {
    
    // physics
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
    
    
    // bird
    var birdTexture = SKTexture(imageNamed: "flappybird")
    birdTexture.filteringMode = SKTextureFilteringMode.Nearest
    
    bird = SKSpriteNode(texture: birdTexture)
    bird.setScale(2)
    bird.position = CGPoint(x: self.frame.size.width * 0.35 ,y: self.frame.size.height * 0.6)
    
    bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/4)
    bird.physicsBody?.dynamic = true
    bird.physicsBody?.allowsRotation = false
    
    self.addChild(bird)
    
    
    // ground
    var groundTexture = SKTexture(imageNamed: "ground")
    
    var sprite = SKSpriteNode(texture: groundTexture)
    sprite.setScale(6.0)
    sprite.position = CGPoint(x: self.size.width/2, y: sprite.size.height/2)
    
    self.addChild(sprite)
    
    var ground = SKNode()
    ground.position = CGPointMake(0, groundTexture.size().height*2)
    ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 8.0))
    
    ground.physicsBody?.dynamic = false
    self.addChild(ground)
    
    
    // pipes
    // create pipes
    pipeUpTexture = SKTexture(imageNamed: "pipeup")
    pipeDownTexture = SKTexture(imageNamed: "pipedown")
    
    // movement of pipes
    let distanceToMove = CGFloat(self.frame.size.width+2.0 * pipeUpTexture.size().width)
    let movePipes = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(0.01 * distanceToMove))
    let removePipes = SKAction.removeFromParent()
    pipesMoveAndRemove = SKAction.sequence([movePipes, removePipes])
    
    // spawn pipes
    let spawn = SKAction.runBlock({() in self.spawnPipes()})
    let delay = SKAction.waitForDuration(NSTimeInterval(2.0))
    let spawnThenDelay = SKAction.sequence([spawn, delay])
    let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
    self.runAction(spawnThenDelayForever)
    
    
  }
  
  func spawnPipes() {
    let pipePair = SKNode()
    pipePair.position = CGPointMake(self.frame.size.width + pipeUpTexture.size().width * 2, 0)
    pipePair.zPosition = -1
    
    let height = UInt32(self.frame.size.height / 4)
    let y = arc4random() % height + height
    
    let pipeDown = SKSpriteNode(texture: pipeDownTexture)
    pipeDown.setScale(4.0)
    pipeDown.position = CGPointMake(0.0, CGFloat(y) + pipeDown.size.height + CGFloat(pipeGap))
    
    pipeDown.physicsBody = SKPhysicsBody(rectangleOfSize: pipeDown.size)
    pipeDown.physicsBody?.dynamic = false
    pipePair.addChild(pipeDown)
    
    let pipeUp = SKSpriteNode(texture: pipeUpTexture)
    pipeUp.setScale(4.0)
    pipeUp.position = CGPointMake(0.0, CGFloat(y))
    
    pipeUp.physicsBody = SKPhysicsBody(rectangleOfSize: pipeUp.size)
    pipeUp.physicsBody?.dynamic = false
    pipePair.addChild(pipeUp)
    
    pipePair.runAction(pipesMoveAndRemove)
    self.addChild(pipePair)
  
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
