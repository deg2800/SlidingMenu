//
//  SlidingMenu.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import SwiftUI


/// Creates a sliding menu. Must be passed an array of MenuItemData from which it will build the menu, and a View as a trailing closure which will be the header for the menu.
/// 
/// Default usage is to create an array of MenuItemData, and pass that array into SlidingMenu, providing a header for the menu as a trailing enclosure.
/// ```
/// let menuItems: [MenuItemData] = [
///                 .init(sfSymbol: "person.fill",
///                 title: "Contacts") {
///                     ContactView()
///                 },
///                 .init(sfSymbol: "bubble.fill",
///                 title: "Chats") {
///                     ChatsView()
///                 },
///                 .init(sfSymbol: "gear",
///                 title: "Settings") {
///                     SettingsView()
///                 }]
///
/// SlidingMenu(menuItems) {
///     HeaderView()
/// }
/// ```
/// Default menu settings such as background color can be changed by adding the `.menuSettings` view modifier
/// ```
/// SlidingMenu(menuItems) {
///     HeaderView()
/// }
/// .menuSettings(menuBackgroundColor: Color.yellow,
///               menuItemTextColor: Color.black,
///               selectedMenuItemTextColor: Color.black,
///               defaultMenuItemFont: Font.title)
///```


public struct SlidingMenu<Content:View> : View {
    @State private var selectedMenuItem: MenuItemData = .init(sfSymbol: "pencil", title: "Default item") {
        Text("This is a placeholder view.\nThis view will not display if an array of MenuItemData is passed to SlidingMenu.")
    }
    @State private var menuOpen = false
    @State var menuItems: [MenuItemData]
    let header: () -> Content
    
    public init(_ menuItems: [MenuItemData], header: @escaping () -> Content) {
        self.menuItems = menuItems
        self.header = header
    }
            
    public var body: some View {
        ZStack {
            selectedMenuItem.view()
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            menuOpen.toggle()
                        }
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title)
                    })
                    .foregroundStyle(.primary)
                    Spacer()
                }
                Spacer()
            }
            .padding()
            Color.gray.opacity(menuOpen ? 0.7 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    if menuOpen {
                        withAnimation {
                            menuOpen.toggle()
                        }
                    }
                }
            HStack {
                GeometryReader { geometry in
                    SMDrawer(menuItemData: menuItems, selectedMenuItem: $selectedMenuItem, menuOpen: $menuOpen) {
                        header()
                    }
                        .frame(width: geometry.size.width * 0.6)
                        .offset(x: menuOpen ? 0 : -geometry.size.width * 0.6)
                }
                Spacer()
            }
        }
        .onAppear {
            if !menuItems.isEmpty {
                selectedMenuItem = menuItems[0]
            }
        }
    }
}

#Preview {
    SlidingMenu([]) {
        Text("Header")
    }
}

public struct MenuSettings: ViewModifier {
    var menuBackgroundColor: Color
    var menuItemTextColor: Color
    var selectedMenuItemTextColor: Color
    var defaultMenuItemFont: Font
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                SMSettings.shared.backgroundColor = menuBackgroundColor
                SMSettings.shared.foregroundTextColor = menuItemTextColor
                SMSettings.shared.selectedForegroundTextColor = selectedMenuItemTextColor
                SMSettings.shared.defaultMenuItemFont = defaultMenuItemFont
            }
    }
}

public extension SlidingMenu {
    
    /// Sets new values for menu parameters
    /// - Parameters:
    ///   - menuBackgroundColor: Color used for the menu and menu item backgrounds. A gradient is applied to the menu background using this color. Default is Color.blue
    ///   - menuItemTextColor: Color used as the foregroundStyle for the text in each menu item. Default is Color.primary
    ///   - selectedMenuItemTextColor: Color used as the foregroundStyle for the text in the selected menu item. Default is Color.white
    ///   - defaultMenuItemFont: Font used for the text in each menu item. Default is Font.body
    /// - Returns: Sets new values for parameter listed. Each parameter will use its default value if omitted.
    func menuSettings(
        menuBackgroundColor: Color = SMSettings.shared.backgroundColor,
        menuItemTextColor: Color = SMSettings.shared.foregroundTextColor,
        selectedMenuItemTextColor: Color = SMSettings.shared.selectedForegroundTextColor,
        defaultMenuItemFont: Font = SMSettings.shared.defaultMenuItemFont
    ) -> some View {
        self.modifier(
            MenuSettings(
                menuBackgroundColor: menuBackgroundColor,
                menuItemTextColor: menuItemTextColor,
                selectedMenuItemTextColor: selectedMenuItemTextColor,
                defaultMenuItemFont: defaultMenuItemFont
            )
        )
    }
}
