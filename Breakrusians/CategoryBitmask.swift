//
//  CategoryBitmask.swift
//  Breakrusians
//
//  Created by Sergey Kletsov on 21.07.2023.
//

enum CategoryBitmask {
    static let none: UInt32         = 0         // 0b00000000
    static let ball: UInt32         = 0b0001    // 0b00000001
    static let paddle: UInt32       = 0b0010    // 0b00000010
    static let block: UInt32        = 0b0100    // 0b00000100
    static let blockOverlay: UInt32 = 0b1000    // 0b00001000
    static let side: UInt32         = 0b10000   // 0b00010000
}
