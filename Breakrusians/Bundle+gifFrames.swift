//
//  Bundle+gifFrames.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 19.07.2023.
//

import ImageIO
import UIKit

extension Bundle {
    func getGifFrames(for gifName: String) -> [UIImage]? {
        guard let url = url(forResource: gifName, withExtension: "gif"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return extractFrames(from: data)
    }

    private func extractFrames(from gifData: Data) -> [UIImage]? {
        guard let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            return nil
        }

        let frameCount = CGImageSourceGetCount(source)
        var frames: [UIImage] = []

        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }

            let frameImage = UIImage(cgImage: cgImage)
            frames.append(frameImage)
        }

        return frames
    }
 }
