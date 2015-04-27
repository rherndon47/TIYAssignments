//
//  GameScene.swift
//  SpriteKitSimpleGame
//
//  Created by Ben Gohlke on 4/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import SpriteKit
// 13 - Add to the top of GameScene.swift adds play music
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String)
{
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if (url == nil)
    {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil
    {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1  // never stops playing
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}

// 6 - Add to top of GameScene.swift
struct PhysicsCategory
{
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Monster   : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
}


// 4 - Add to top of GameScene.swift
// doing vector math. redefining math functions

func + (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat
    {
    return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint
{
    func length() -> CGFloat
    {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint
    {
        return self / length()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate  // adding delegates
{
    
    let player = SKSpriteNode(imageNamed: "player")
    // 17 - Add as a property of class
    var monstersDestroyed = 0
    
    override func didMoveToView(view: SKView)
    {
        // 14 - Add to the beginning of didMoveToView
        playBackgroundMusic("background-music-aac.caf")
        backgroundColor = SKColor.whiteColor()
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        
        // 3 - Add to end of didMoveToView()
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addMonster),
                SKAction.waitForDuration(1.0)])))
        // 8 - Add to didMoveToView, after player sprite is added to the scene
        physicsWorld.gravity = CGVectorMake(0, 0) // turns off gravity
        physicsWorld.contactDelegate = self       // sets ourself to be notified when contact is made
    }
    
    // 1
    
    func random() -> CGFloat
    {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat
    {
        return random() * (max - min) + min
    }
    
    func addMonster()
    {
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "monster")
        
        // 9 - Add to addMonster function, after creating monster sprite
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
        monster.physicsBody?.dynamic = true   // physics engine will not control monster
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: size.height - monster.size.height/2)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
        
        // Add the monster to the scene
        addChild(monster)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: -monster.size.width/2, y: actualY), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        // 16 - Replace the line in addMonster that runs the actions on the monster
        let loseAction = SKAction.runBlock()
        {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
    }
    
    // 5 - Add as new function inside class
    // executed when finger lifts off of screen (only first touch)
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // 15 - Add to the top of touchesEnded
        runAction(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)  // where in scene was touch
        
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        
        // 10 - Add to touchesEnded, after projectile's position is set
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.dynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true  // more procise collision detection
        
        let offset = touchLocation - projectile.position
        if (offset.x < 0) { return }
        
        addChild(projectile)
        
        let direction = offset.normalized()
        let shootAmount = direction * 1000
        let realDest = shootAmount + projectile.position
        
        let actionMove = SKAction.moveTo(realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    // 11 - Add new function to class
    func projectileDidCollideWithMonster(projectile:SKSpriteNode, monster:SKSpriteNode)
    {
        println("Hit")
        projectile.removeFromParent()
        monster.removeFromParent()
        // 18 - Add to bottom of projectile(_:didCollideWithMonster:)
        monstersDestroyed++
        if (monstersDestroyed > 30)
        {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    // 12 - Add new function to class
    func didBeginContact(contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // if true then detected a collision
        if ((firstBody.categoryBitMask & PhysicsCategory.Monster != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0))
        {
            projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, monster: secondBody.node as! SKSpriteNode)
        }
    }
    
}



