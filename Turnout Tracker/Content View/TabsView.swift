//
//  Shows three tab system of Group, Events, and Lists tabs.
//  Created by Stephen Boussarov on 9/8/20.
//

import SwiftUI

/*
 Shown after selecting a group. Allows the user to switch between the different aspects of a Group.
 */
struct TabsView: View {
    
    // holds the names of the current group and the page shown
    @ObservedObject var viewRouter: ViewRouter
    
    // var determining which tab is showing
    @State private var selection = 1
    
    // body of view
    var body: some View {
        
                
        // creates Tabs
        TabView(selection: $selection) {
            
            // first tab
            HomeTabView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName: "house.fill").imageScale(.large)
                    Text("Home")
            }.tag(1)
            
            // second tab
            MainEventsTabView(viewRouter: viewRouter)
                .tabItem {
                    
                    Image(systemName: "calendar").imageScale(.large)
                    Text("Events")
                    
        
            }.tag(2)
        
            
            // third tab
            MyListsTabView(viewRouter: viewRouter)
                .tabItem {
                    Image(systemName:"book.fill").imageScale(.large)
                    Text("Lists")
                }.tag(3)

        
            
        } /* end TabView */
        .accentColor(Color.white)
        .navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
        .onDisappear(perform: {
         self.navigationBarColor(backgroundColor: UIColor(named: "primary"),textColor: UIColor.white)
        })
    }
}

