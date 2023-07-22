//
//  Paddle.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 19.07.2023.
//

import SpriteKit

final class Paddle: SKSpriteNode {

    init() {
        let paddleTexture = SKTexture(imageNamed: "himars")
        super.init(texture: paddleTexture, color: .clear, size: paddleTexture.size())
        setupPhysics()
        setupFlag()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupFlag() {
        guard let flagFrames = Bundle.main.getGifFrames(for: "ukrainian-flag") else {
            return
        }
        let flagTextures = flagFrames.map { SKTexture(image: $0) }
        let flagAnimation = SKAction.animate(with: flagTextures, timePerFrame: 0.1)
        let flag = SKSpriteNode(texture: flagTextures.first)

        flag.run(SKAction.repeatForever(flagAnimation))
        flag.resizeProportionally(toHeight: 12)
        flag.position = .init(x: 28, y: 27)
        flag.xScale = -1
        flag.zPosition = 1

        addChild(flag)
    }

    private func setupPhysics() {
        var size = self.size
        size.height -= 30
        physicsBody = .init(rectangleOf: size)

        physicsBody?.isDynamic = false
        physicsBody?.mass = 1
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 0

        physicsBody?.categoryBitMask = CategoryBitmask.paddle
        physicsBody?.contactTestBitMask = CategoryBitmask.ball
        physicsBody?.collisionBitMask = CategoryBitmask.ball
    }
}

extension SKSpriteNode {

    func resizeProportionally(toHeight newHeight: CGFloat) {
        let aspectRatio = size.width / size.height
        let newWidth = newHeight * aspectRatio
        self.size = .init(width: newWidth, height: newHeight)
    }

    func resizeProportionally(toWidth newWidth: CGFloat) {
        let aspectRatio = size.height / size.width
        let newHeight = newWidth * aspectRatio
        self.size = .init(width: newWidth, height: newHeight)
    }
}
