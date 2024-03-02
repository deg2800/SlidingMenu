//
//  SMMenuItem.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import SwiftUI

struct SMMenuItem: View {
    
    var menuItemData: MenuItemData
    @Binding var selectedMenuItem: MenuItemData
    var foregroundColor: Color = .primary
    var font: Font = .body
    let action: () -> Void

    /// Initializes a Menu Item and sets font to body and color to primary
    init(_ menuItemData: MenuItemData, selectedMenuItem: Binding<MenuItemData>, action: @escaping () -> Void) {
        self.menuItemData = menuItemData
        self._selectedMenuItem = selectedMenuItem
        self.foregroundColor = SMSettings.shared.foregroundTextColor
        self.font = SMSettings.shared.defaultMenuItemFont
        self.action = action
    }
        
    /// Initializes a Menu Item with ability to change text color and font. Defaults are primary and body
    init(_ menuItemData: MenuItemData, selectedMenuItem: Binding<MenuItemData>, foregroundColor: Color = .primary, font: Font = .body, selected: Bool, action: @escaping () -> Void) {
        self.menuItemData = menuItemData
        self._selectedMenuItem = selectedMenuItem
        self.foregroundColor = foregroundColor
        self.font = font
        self.action = action
    }
    
    var backgroundColor: Color {
        if menuItemData == selectedMenuItem {
            return SMSettings.shared.backgroundColor
        } else {
            return Color.white
        }
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Label(menuItemData.title, systemImage: menuItemData.sfSymbol)
                    .foregroundStyle(menuItemData == selectedMenuItem ? SMSettings.shared.selectedForegroundTextColor : foregroundColor)
                    .font(font)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(8)
        })
        .background(RoundedRectangle(cornerRadius: 10).fill(backgroundColor.shadow(.drop(radius: 2))))
        .contentShape(Rectangle())
    }
}
