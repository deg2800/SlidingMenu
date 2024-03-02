//
//  SMDrawer.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import SwiftUI

public struct SMDrawer<Content:View> : View {
    var menuItemData: [MenuItemData]
    @Binding var selectedMenuItem: MenuItemData
    @Binding var menuOpen: Bool
    let header: () -> Content
    
    init(menuItemData: [MenuItemData], selectedMenuItem: Binding<MenuItemData>, menuOpen: Binding<Bool>, header: @escaping () -> Content) {
        self.menuItemData = menuItemData
        self._selectedMenuItem = selectedMenuItem
        self._menuOpen = menuOpen
        self.header = header
    }
    
    public var body: some View {
        ZBackground {
            HStack {
                VStack(alignment: .leading) {
                    header()
                    ForEach(menuItemData.indices, id: \.self) { index in
                        SMMenuItem(menuItemData[index], selectedMenuItem: $selectedMenuItem) {
                            withAnimation {
                                self.selectedMenuItem = menuItemData[index]
                                if menuOpen {
                                    self.menuOpen.toggle()
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    func isSelected(_ menuItemData: MenuItemData) -> Bool {
        if selectedMenuItem.title == menuItemData.title {
            return true
        } else {
            return false
        }
    }

}
