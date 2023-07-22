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
        physicsBody = .init(polygonFrom: .init(ellipseIn: frame, transform: nil))

        physicsBody?.allowsRotation = false
        physicsBody?.mass = 1
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0

        physicsBody?.categoryBitMask = CategoryBitmask.ball
        physicsBody?.contactTestBitMask = CategoryBitmask.paddle | CategoryBitmask.side | CategoryBitmask.block
        physicsBody?.collisionBitMask = CategoryBitmask.paddle | CategoryBitmask.side | CategoryBitmask.block
    }
}
