//
//  Color+Extensions.swift
//  GameFest
//
//  Created by Paul Merceur on 17/03/2023.
//

import Foundation
import SwiftUI

extension Color {
    static func adaptiveBlue(colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color(red: 0, green: 0.35, blue: 0.6) : Color(red: 0, green: 0.45, blue: 0.8)
    }
}
