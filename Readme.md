# Sliding Menu
A Swift framework for iOS projects which creates an easy sliding menu you can drop in your apps

## Usage
Add this framework using the SWift Package Manager and `import SlidingMenu`
Create an array of MenuItemData, pass the array as a parameter to `SlidingMenu` and provide a view in a trailing enclosure to be used for the menu header
```
let menuItems: [MenuItemData] = [
                .init(sfSymbol: "person.fill",
                title: "Contacts") {
                    ContactView()
                },
                .init(sfSymbol: "bubble.fill",
                title: "Chats") {
                    ChatsView()
                },
                .init(sfSymbol: "gear",
                title: "Settings") {
                    SettingsView()
                }]

SlidingMenu(menuItems) {
    HeaderView()
}
```

A default sliding menu is created with a background color of blue, a menu item text color of primary, a selected menu item text color of white. The background color has a gradient applied for the menu background. The background color is also used without a gradient as the background color of the selected menu item.

These settings can be overridden by using the `.menuSettings` view modifier:
```
SlidingMenu(menuItems) {
    HeaderView()
}
.menuSettings(menuBackgroundColor: Color.yellow,
              menuItemTextColor: Color.black,
              selectedMenuItemTextColor: Color.black,
              defaultMenuItemFont: Font.title)
```
