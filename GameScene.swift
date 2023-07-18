import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Set up the player
    let player = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))

    // Set up the platforms
    let platform1 = SKSpriteNode(color: SKColor.black, size: CGSize(width: 100, height: 20))
    let platform2 = SKSpriteNode(color: SKColor.black, size: CGSize(width: 100, height: 20))
    let platform3 = SKSpriteNode(color: SKColor.black, size: CGSize(width: 100, height: 20))
    
    // Declare the floor without initializing it
    let floor = SKSpriteNode()

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.zPosition = 1
        
        // Initialize and position the floor
        floor.color = .black
        floor.size = CGSize(width: size.width, height: 20)
        let floorHeight = floor.size.height / 2
        floor.position = CGPoint(x: size.width / 2, y: floorHeight)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        addChild(floor)

        // Position the player on the floor
        player.position = CGPoint(x: size.width * 0.2, y: floorHeight + player.size.height / 2)
        addChild(player)
        
        // Randomize and position the platforms
        let platformHeight1 = floorHeight + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
        platform1.position = CGPoint(x: size.width, y: platformHeight1)
        addChild(platform1)

        let platformHeight2 = floorHeight + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
        platform2.position = CGPoint(x: size.width + platform1.size.width, y: platformHeight2)
        addChild(platform2)

        let platformHeight3 = floorHeight + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
        platform3.position = CGPoint(x: size.width + platform1.size.width * 2, y: platformHeight3)
        addChild(platform3)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Move the platforms
        platform1.position = CGPoint(x: platform1.position.x - 2, y: platform1.position.y)
        platform2.position = CGPoint(x: platform2.position.x - 2, y: platform2.position.y)
        platform3.position = CGPoint(x: platform3.position.x - 2, y: platform3.position.y)
        
        // Check if we need to move the first platform to the right
        if platform1.position.x + platform1.size.width < 0 {
            let platformHeight = size.height * 0.1 + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
            platform1.position = CGPoint(x: platform3.position.x + platform3.size.width, y: platformHeight)
        }
        
        // Check if we need to move the second platform to the right
        if platform2.position.x + platform2.size.width < 0 {
            let platformHeight = size.height * 0.1 + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
            platform2.position = CGPoint(x: platform1.position.x + platform1.size.width, y: platformHeight)
        }

        // Check if we need to move the third platform to the right
        if platform3.position.x + platform3.size.width < 0 {
            let platformHeight = size.height * 0.1 + CGFloat.random(in: (size.height * 0.1)...(size.height * 0.3))
            platform3.position = CGPoint(x: platform2.position.x + platform2.size.width, y: platformHeight)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // The player jumps when the screen is touched
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
}
