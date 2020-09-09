//
//  The first screen that is shown when the app is first opened.
//
//  Created by Stephen Boussarov on 6/19/20.
//

import SwiftUI
import Foundation
import Combine

/*
    Displays the root view for the app.
 */
struct ContentView: View {
    
    // determines if TabBar should be hidden
    public static var hide = false
    
    // holds the names of the current group and the page shown
    @ObservedObject var viewRouter: ViewRouter = ViewRouter()
    
    // the default font of all views
    public var fontName = "Helvetica"
    
    // the font size of tutorial button
    var tutorialButtonFontSize = 20
    // the opacity of the tutorial button
    var tutorialButtonOpacity = 0.6
    // the opacity of background when tutorial is shown
    var backgroundOpacity = 0.5
    // generic font size
    var fontSize = 21
    
    // states if app is being opened for the first time
    var firstTime: Bool
    
    // states if tutorial should be shown
    @State var showTut = true
    
    // states if tutorial is being shown for the first time
    @State var firstTut = true
    
    // run when the view is first shown
    init() {
        // Sets tab bar color
        UITabBar.appearance().barTintColor = UIColor(named: "primary")
        
        // Sets list header color
        UITableViewHeaderFooterView.appearance().tintColor = UIColor(named: "secondary")
        
        // Removes top borders on form
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().backgroundColor = UIColor(named: "clear")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "clear")
        
        // hides tab bar
        UITabBar.appearance().isHidden = ContentView.hide
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)

        
        // determines if the app is being launched for first time or not
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
                UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                firstTime = true
        } else {
            firstTime = false
        }
    }
    
    // body of view
    var body: some View {
        
        VStack {
            
            // if groups page is being shown
            if self.viewRouter.page == "groups" {
                
                ZStack{
                    // sets color of ZStack
                    ColorManager.secondary.edgesIgnoringSafeArea(.all)
                    
                    // runs GroupsView
                    GroupsView(viewRouter: viewRouter)
                    
                    // Redo Tutorial Button
                    VStack {
                        Spacer()
                        
                        // Button to show tutorial
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showTut = true
                                self.firstTut = false
                            }) {
                                Text("View Tutorial")
                                    .foregroundColor(Color.white)
                                    .font(thisFont(size: tutorialButtonFontSize))
                                    .opacity(tutorialButtonOpacity)
                                    
                            }
                            
                            Spacer()
                        }

                    }
                    
                    // determines if tutorial should be shown
                    if (self.firstTut && self.firstTime) || (!self.firstTut && self.showTut) {
                        Rectangle()
                            .edgesIgnoringSafeArea(.vertical)
                            .opacity(backgroundOpacity)
                        // tutorial screens are run
                        NewUser(showTut: self.$showTut, firstTut: self.$firstTut)
                    }
                    
                }
                
            // if tabs pages should be shown
            } else if self.viewRouter.page == "tabs" {
                TabsView(viewRouter:  viewRouter)
            }
        }.font(Font.custom(fontName, size: fontSize))
    }
}
