//
//  NavBarModifier.swift
//  Eventend
//
//  Created by Stephen Boussarov on 7/10/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    // color of background
    var backgroundColor: UIColor?
    // color of text
    var textColor: UIColor?
    
    // initialization that sets proper NavBar colors
    init( backgroundColor: UIColor?, textColor: UIColor?) {
        // assigns background and text colors
        self.backgroundColor = backgroundColor
        self.textColor = textColor!
        
        // var for appearence of navBar
        let coloredAppearance = UINavigationBarAppearance()
        
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        
        // sets color of text
        coloredAppearance.titleTextAttributes = [.foregroundColor: textColor!]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor!]
        
        // sets color of background
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        // sets color of non-title text
        UINavigationBar.appearance().tintColor = UIColor(named: "primary")

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    // ignores return requirement
    @discardableResult
    
    /*
     * Changes text and background colors of NavBar
     * Parameters: backgroundColor - color of background
     *             textColor - color of text
     */
    func navigationBarColor( backgroundColor: UIColor?, textColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
    }

}
