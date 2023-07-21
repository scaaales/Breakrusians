//
//  GameScene.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 19.07.2023.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {

    private var safeArea: UIEdgeInsets = .zero
    private var initialTouchPosition: CGPoint = .zero

    private var initialBallVelocity: CGVector?
    private var initialVelocityAngle: CGFloat?

    private let paddle = Paddle()
    private let ball = Ball()

    private var isBallMoving = false

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self

        addChild(paddle)

        ball.zPosition = 2
        ball.zRotation = .pi / 4
        addChild(ball)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        setupPositions()
        setupScreenEdges()
    }

    func setSafeArea(_ safeArea: UIEdgeInsets) {
        self.safeArea = safeArea
        setupPositions()
        setupScreenEdges()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        initialTouchPosition = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        let paddleWidthHalf = paddle.size.width / 2

        let delta = touchLocation.x - initialTouchPosition.x

        paddle.position.x += delta
        let direction: CGFloat = delta > 0 ? 1 : -1
        paddle.xScale = direction

        let widthHalf = size.width / 2
        let leftLimit = -widthHalf + paddleWidthHalf
        let rightLimit = widthHalf - paddleWidthHalf
        paddle.position.x = min(max(paddle.position.x, leftLimit), rightLimit)

        initialTouchPosition = touchLocation

        if !isBallMoving && delta != 0 {
            // Start the ball's movement
            startBallMovement(direction: direction)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ball.position.y < -paddle.size.height / 2 {
            // Game over, implement game over logic here
            // For example, show a game over screen or restart the game
        }
    }

    private func setupScreenEdges() {
        let screenBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody = screenBody
        self.physicsBody?.friction = 0

        self.physicsBody?.categoryBitMask = CategoryBitmask.side
        self.physicsBody?.collisionBitMask = CategoryBitmask.ball
        self.physicsBody?.contactTestBitMask = CategoryBitmask.ball
    }


    private func startBallMovement(direction: CGFloat) {
        let initialSpeed: CGFloat = 200
        let initialVelocity = CGVector(dx: direction * initialSpeed, dy: initialSpeed)

        // Calculate the initial velocity angle
        initialVelocityAngle = atan2(initialVelocity.dy, initialVelocity.dx)

        // Apply the initial velocity to the ball's physics body
        ball.physicsBody?.velocity = initialVelocity
        ball.zRotation = direction >= 1 ? .pi / 4 : 3 * .pi / 4

        initialBallVelocity = initialVelocity

        // Set the isBallMoving flag to true to indicate that the ball has started moving
        isBallMoving = true
    }

    private func setupPositions() {
        paddle.position = .init(x: .zero, y: -size.height / 2 + safeArea.bottom + paddle.size.height / 2)
        guard !isBallMoving else {
            return
        }
        ball.position = .init(x: 10, y: paddle.position.y + 30)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        // Ball contacts paddle
        if contactMask == (CategoryBitmask.ball | CategoryBitmask.paddle) {
            ballBouncedOffPaddle()
        }

        // Ball contacts side of the screen
        if contactMask == (CategoryBitmask.ball | CategoryBitmask.side) {
            ballBouncedOffSide(contact: contact)
        }
    }

    // Ball bounced off the paddle
    func ballBouncedOffPaddle() {
        // Add any bounce behavior you want here
        // For example, you can change the ball's velocity or direction
    }

    // Ball bounced off the side of the screen
    func ballBouncedOffSide(contact: SKPhysicsContact) {
        guard let physicsBody = ball.physicsBody else {
            return
        }

        let velocity = physicsBody.velocity
        let velocityAngle = atan2(velocity.dy, velocity.dx)

        ball.run(.rotate(toAngle: velocityAngle, duration: 0))
    }
}
