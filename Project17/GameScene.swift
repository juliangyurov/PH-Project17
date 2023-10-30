//
//  GameScene.swift
//  Project17
//
//  Created by Yulian Gyuroff on 30.10.23.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["ball","hammer","tv"]
    var gameTimer: Timer?
    var isGameOver = false
    var timeInterval = 1.0
    var numEnemies = 0 {
        didSet {
            scoreLabel.text = "Score: \(score) Enemies: \(numEnemies)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score) Enemies: \(numEnemies)"
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        print("timeInterval: \(timeInterval)")
    }
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        numEnemies += 1
        if numEnemies % 20 == 0 {
            timeInterval -= 0.1
            if timeInterval < 0.35 {
                timeInterval = 0.35
            }
            guard gameTimer != nil else { return }
            gameTimer?.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
            print("timeInterval: \(timeInterval)")
        }
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        //sprite.physicsBody?.contactTestBitMask = 1
        
    }
        
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        for node in children {
            if node.position.x < -100 {
                node.removeFromParent()
            }
        }
        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesMoved")
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        if location.y < 100 {
            location.y = 100
        }else if location.y > 668 {
            location.y = 668
        }
        player.position = location
        //print("touchesMoved x=\(location.x) y=\(location.y)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isGameOver {
            //print("touchesEnded")
            let explosion = SKEmitterNode(fileNamed: "explosion")!
            explosion.position = player.position
            addChild(explosion)
            player.removeFromParent()
            isGameOver = true
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //let location = CGPoint(x: (contact.bodyA.node?.position.x)! , y: (contact.bodyA.node?.position.y)!)
        
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        //explosion.position = location
        addChild(explosion)
        player.removeFromParent()
        isGameOver = true
        
        gameTimer?.invalidate()
        gameTimer = nil
    }
}
