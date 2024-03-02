//
//  SMSettings.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import Foundation
import SwiftUI

public class SMSettings {
    public static let shared = SMSettings()
    public var backgroundColor = Color.blue
    public var foregroundTextColor = Color.primary
    public var selectedForegroundTextColor = Color.white
    public var defaultMenuItemFont = Font.body
}
