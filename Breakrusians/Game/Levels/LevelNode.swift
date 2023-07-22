//
//  LevelNode.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 21.07.2023.
//

import SpriteKit

final class LevelNode: SKReferenceNode {

    private var maskNodes: [SKSpriteNode: SKSpriteNode] = [:]

    override func didLoad(_ node: SKNode?) {
        super.didLoad(node)

        var imageNode: SKSpriteNode?
        var blockNodes: [SKSpriteNode] = []

        // Access and store references to specific nodes
        enumerateChildNodes(withName: "//*") { node, _ in
            if let node = node as? SKSpriteNode {
                if node.name == "background" {
                    imageNode = node
                } else {
                    blockNodes.append(node)
                }
            }
        }

        if let imageNode = imageNode {
            let cropNode = SKCropNode()
            cropNode.zPosition = 1

            cropNode.maskNode = SKNode()
            for blockNode in blockNodes {
                let copyBlockNode = blockNode.copy() as! SKSpriteNode
                
                blockNode.physicsBody = SKPhysicsBody(rectangleOf: blockNode.size)
                blockNode.physicsBody?.categoryBitMask = CategoryBitmask.block
                blockNode.physicsBody?.collisionBitMask = CategoryBitmask.ball
                blockNode.physicsBody?.contactTestBitMask = CategoryBitmask.ball
                blockNode.physicsBody?.isDynamic = false

                blockNode.alpha = .zero

                cropNode.maskNode?.addChild(copyBlockNode)
                maskNodes[blockNode] = copyBlockNode
            }

            addChild(cropNode)

            imageNode.zPosition = 2
            let imageCopy = imageNode.copy() as! SKSpriteNode
            cropNode.addChild(imageCopy)
            imageNode.removeFromParent()
        }
    }

    func removeNode(_ node: SKSpriteNode) {
        if let mask = maskNodes[node] {
            mask.removeFromParent()
        }
        node.removeFromParent()
        maskNodes.removeValue(forKey: node)
    }

}
