//
//  ZBackground.swift
//  SlidingMenu
//
//  Created by Derrick Goodfriend on 2/28/24.
//

import SwiftUI

struct ZBackground<Content:View> : View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content
    }
    
    let backgroundGradient = SMSettings.shared.backgroundColor.gradient
    
    var body: some View {
        ZStack {
            Color.clear
                .overlay(
                    backgroundGradient
                    )
                .ignoresSafeArea()
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
