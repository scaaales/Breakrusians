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
        setupPaddle()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupPaddle() {
        guard let flagFrames = Bundle.main.getGifFrames(for: "ukrainian-flag") else {
            return
        }
        let flagTextures = flagFrames.map { SKTexture(image: $0) }
        let flagAnimation = SKAction.animate(with: flagTextures, timePerFrame: 0.1)
        let flag = SKSpriteNode(texture: flagTextures.first) // Set initial texture to the first frame
        flag.run(SKAction.repeatForever(flagAnimation))
        addChild(flag)
        flag.resizeProportionally(toHeight: 12)
        flag.position = .init(x: 28, y: 27)
        flag.xScale = -1
        flag.zPosition = 1
    }

    // Add any additional methods and functionality specific to the paddle here
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
