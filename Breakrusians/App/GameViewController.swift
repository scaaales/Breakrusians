//
//  GameViewController.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 19.07.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    private var scene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit

                // Present the scene
                view.presentScene(scene)
                self.scene = scene
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        scene?.setSafeArea(view.safeAreaInsets)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scene?.size = view.bounds.size
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
