//
//  MenuItemData.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import SwiftUI

public struct MenuItemData: Equatable {
    public static func == (lhs: MenuItemData, rhs: MenuItemData) -> Bool {
        lhs.title == rhs.title
    }
    
    public var sfSymbol: String
    public var title: String
    public var view: () -> AnyView
    
    public init<Content: View>(sfSymbol: String, title: String, @ViewBuilder view: @escaping () -> Content) {
        self.sfSymbol = sfSymbol
        self.title = title
        self.view = { AnyView(view()) }
    }
}
