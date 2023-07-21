//
//  Ball.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 21.07.2023.
//

import SpriteKit

final class Ball: SKSpriteNode {

    init() {
        let ballTexture = SKTexture(imageNamed: "missile")
        super.init(texture: ballTexture, color: .clear, size: ballTexture.size())
        resizeProportionally(toWidth: 35)
        setupPhysics()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupPhysics() {
//        let radius = frame.height / 2
//        let center = CGPoint(x: frame.maxX - radius, y: frame.maxY - radius)

        let radius = frame.width / 2
        let center = CGPoint.zero

        physicsBody = .init(circleOfRadius: radius, center: center)

        physicsBody?.mass = 1
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0

        physicsBody?.categoryBitMask = CategoryBitmask.ball
        physicsBody?.contactTestBitMask = CategoryBitmask.paddle | CategoryBitmask.side
        physicsBody?.collisionBitMask = CategoryBitmask.paddle | CategoryBitmask.side
    }
}
