//
//  ColorExtansions.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 10/11/1445 AH.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Double(Int(color >> 16) & mask) / 255.0
        let g = Double(Int(color >> 8) & mask) / 255.0
        let b = Double(Int(color) & mask) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
