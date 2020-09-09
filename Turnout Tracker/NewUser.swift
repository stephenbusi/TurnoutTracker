//
//  NewUser.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/23/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI


struct NewUser: View {
    @Binding var showTut: Bool
    @Binding var firstTut: Bool
    
    @State var nextPage = "page1"
    var body: some View {
        ZStack {
            Color.white
            
            
            VStack {
                Text("Welcome to\nTurnout Tracker!")
                    .font(.custom("Futura Bold", size: 30))
                    .padding(.top, 45)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.secondary)
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 225, height: 225)
                    .padding(.top, 30)
                
                Text("Turnout Tracker uses a system of Groups, Lists, and Events to make taking attendance as intuitive and convenient as possible.")
                    .font(thisFont( size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(width: 325)
                    .padding(.top, 35)
                    
                
                Spacer()
                
                HStack {
                    Text("1/8")
                        .padding(.leading, 15)
                        .padding(.bottom, 5)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = "page2"
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.primary)
                                .frame(width:150, height:40)
                                .cornerRadius(20)
                            Text("Start Tutorial")
                                .foregroundColor(Color.white)
                        }
                    }
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 5)
                
            }
            
            VStack {
                Image("TurnoutTracker_Icon_secondary_color")
                    .resizable()
                    .frame(width: 340, height: 340)
                    .padding(.top, 110)
                Spacer()
            }


            if nextPage == "page2" {
                NewUser2(nextPage: self.$nextPage)
            }
            
            if nextPage == "page3" {
                NewUser3(nextPage: self.$nextPage)
            }
            
            if nextPage == "page4" {
                NewUser4(nextPage: self.$nextPage)
            }
            
            if nextPage == "page5" {
                NewUser5(nextPage: self.$nextPage)
            }
            
            if nextPage == "page6" {
                NewUser6(nextPage: self.$nextPage)
            }
            
            if nextPage == "page7" {
                NewUser7(nextPage: self.$nextPage)
            }
            
            if nextPage == "page8" {
                NewUser8(showTut: self.$showTut, nextPage: self.$nextPage, firstTut: self.$firstTut)
            }

        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser2: View {
    @Binding var nextPage: String
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Text("Groups Page")
                    .font(.custom("Futura Bold", size: 30))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.secondary)
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 225, height: 400)

                
                Text("Start off by creating a group. This can represent any organization, club, or team.")
                    .font(thisFont( size: 15))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(width: 325)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("2/8")
                        .padding(.leading,15)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = "page1"
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                    .padding(.trailing, 15)
                    
                    Button(action: {
                        self.nextPage = "page3"
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                        .padding(.trailing,15)
                }
                .padding(.bottom, 15)
                
            }
            
            // Screen Shot
            VStack {
                Image("Groups 1")
                    .resizable()
                    .frame(width: 200, height: 420)
                    .border(ColorManager.secondary)
                    .padding(.top, 65)
                Spacer()
            }
            
        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser3: View {
    @Binding var nextPage: String
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Text("Lists Page")
                    .font(.custom("Futura Bold", size: 30))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.secondary)
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 225, height: 400)

                
                Text("After first creating a group, it is recommended that you create a list.")
                    .font(thisFont( size: 15))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(width: 325)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("3/8")
                        .padding(.leading,15)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = "page2"
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                    .padding(.trailing, 15)
                    
                    Button(action: {
                        self.nextPage = "page4"
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                        .padding(.trailing,15)
                }
                .padding(.bottom, 15)
                
            }
            
            // Screen Shot
            VStack {
                Image("Lists 1")
                    .resizable()
                    .frame(width: 200, height: 420)
                    .border(ColorManager.secondary)
                    .padding(.top, 65)
                Spacer()
            }
            
        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser4: View {
    @Binding var nextPage: String

    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Text("Individual List")
                    .font(.custom("Futura Bold", size: 30))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.secondary)
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 225, height: 400)

                
                Text("After tapping on a list, you can add the names of people you expect to show up to events.")
                    .font(thisFont( size: 15))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(width: 325)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("4/8")
                        .padding(.leading,15)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = "page3"
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                    .padding(.trailing, 15)
                    
                    Button(action: {
                        self.nextPage = "page5"
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                        .padding(.trailing,15)
                }
                .padding(.bottom, 15)
                
            }
            
            // Screen Shot
            VStack {
                Image("List 1")
                    .resizable()
                    .frame(width: 200, height: 420)
                    .border(ColorManager.secondary)
                    .padding(.top, 65)
                    
                Spacer()
            }
            
        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser5: View {
    @Binding var nextPage: String
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Text("Events Page")
                    .font(.custom("Futura Bold", size: 30))
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorManager.secondary)
                
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 225, height: 400)

                
                Text("Create events to track attendance at meetings or other occasions. When creating an event, select the list that you made earlier to automatically use those names.")
                    .font(thisFont( size: 15))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                    .frame(width: 325)
                    .padding(.top)
                
                Spacer()
                
                HStack {
                    Text("5/8")
                        .padding(.leading,15)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = "page4"
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                    .padding(.trailing, 15)
                    
                    Button(action: {
                        self.nextPage = "page6"
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(ColorManager.primary)
                    }
                        .padding(.trailing,15)
                }
                .padding(.bottom, 15)
                
            }
            
            // Screen Shot
            VStack {
                Image("Events 1")
                    .resizable()
                    .frame(width: 200, height: 420)
                    .border(ColorManager.secondary)
                    .padding(.top, 65)
                    
                Spacer()
            }
            
        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser6: View {
    @Binding var nextPage: String
    
    var body: some View {
        ZStack {
            Color.white
                
                VStack {
                    Text("Individual Event")
                        .font(.custom("Futura Bold", size: 30))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                        .foregroundColor(ColorManager.secondary)
                    
                    Rectangle()
                        .foregroundColor(Color.white)
                        .frame(width: 225, height: 400)

                    
                    Text("Simply check off people who show up to your event to mark them as 'attended'. Any changes you make to an event are automatically saved and can be edited at any time.")
                        .font(thisFont( size: 15))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.black)
                        .opacity(0.6)
                        .frame(width: 325)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        Text("6/8")
                            .padding(.leading,15)
                            .opacity(0.3)
                        
                        Spacer()
                        
                        Button(action: {
                            self.nextPage = "page5"
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(ColorManager.primary)
                        }
                        .padding(.trailing, 15)
                        
                        Button(action: {
                            self.nextPage = "page7"
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(ColorManager.primary)
                        }
                            .padding(.trailing,15)
                    }
                    .padding(.bottom, 15)
                    
                }
                
                // Screen Shot
                VStack {
                    Image("Event 1")
                        .resizable()
                        .frame(width: 200, height: 420)
                        .border(ColorManager.secondary)
                        .padding(.top, 65)
                        
                    Spacer()
                }
                
            }.frame(width: 350, height:630)
            .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser7: View {
    @Binding var nextPage: String
    
    var body: some View {
        ZStack {
            Color.white
                
                VStack {
                    Text("Home Page")
                        .font(.custom("Futura Bold", size: 30))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                        .foregroundColor(ColorManager.secondary)
                    
                    Rectangle()
                        .foregroundColor(Color.white)
                        .frame(width: 225, height: 400)

                    
                    Text("Here, you can view a group's general statistics. You can also tap on a name to view an attendee's statistics.")
                        .font(thisFont( size: 15))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.black)
                        .opacity(0.6)
                        .frame(width: 325)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        Text("7/8")
                            .padding(.leading,15)
                            .opacity(0.3)
                        
                        Spacer()
                        
                        Button(action: {
                            self.nextPage = "page6"
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(ColorManager.primary)
                        }
                        .padding(.trailing, 15)
                        
                        Button(action: {
                            self.nextPage = "page8"
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(ColorManager.primary)
                        }
                            .padding(.trailing,15)
                    }
                    .padding(.bottom, 15)
                    
                }
                
                // Screen Shot
                VStack {
                    Image("Home 1")
                        .resizable()
                        .frame(width: 200, height: 420)
                        .border(ColorManager.secondary)
                        .padding(.top, 65)
                        
                    Spacer()
                }
                
            }.frame(width: 350, height:630)
            .cornerRadius(20).shadow(radius: 20)
    }
}

struct NewUser8: View {
    @Binding var showTut: Bool
    @Binding var nextPage: String
    @Binding var firstTut: Bool
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                
                Text("Additional Info")
                .font(.custom("Futura Bold", size: 30))
                .padding(.top)
                .multilineTextAlignment(.center)
                .foregroundColor(ColorManager.secondary)
                
                
                VStack {
                    
                    // Add Info
                    HStack{
                        // Add Button
                        AddButton()
                            .offset(x:40)
                        Spacer()
                        // Add Button Text
                        Text("Tap to add a new Group, List, or Event")
                            .frame(width: 150)
                    }
                    
                    Spacer()
                    
                    HStack{
                        // Delete Swipe
                        Text("Delete")
                            .foregroundColor(Color.white).frame(width:130, height: 50).background(Color.red)
                        Spacer()
                        // Delete Text
                        Text("Swipe left on the name of a Group, List, Event, or Person to delete")
                            .frame(width: 150)
                    }
                    
                    Spacer()
                    
                    HStack{
                        // Edit Pencil Button
                        ZStack {
                            Circle()
                                .fill(ColorManager.primary)
                                .frame(width: 50, height: 50)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "pencil")
                                .foregroundColor(ColorManager.primary)
                        }
                        .offset(x:40)
                        Spacer()
                        // Edit Text
                        Text("Tap to edit a Group, List, or Event")
                            .frame(width: 150)
                    }
                    
                    Spacer()
                    
                    HStack{
                        // Info Button
                        ZStack {
                            Circle()
                                .fill(ColorManager.primary)
                                .frame(width: 50, height: 50)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: "info")
                                .foregroundColor(ColorManager.primary)
                        }
                        .offset(x:40)
                        Spacer()
                        // Info Text
                        Text("Tap to get further info about a page")
                            .frame(width: 150)
                    }
                }
                .frame(width: 300, height: 380).foregroundColor(Color.gray).font(.system(size: 15))
                
                
                
            
                
                
                
                Text("Enjoy Turnout Tracker!")
                    .font(thisFont(size: 30)).fontWeight(.bold).padding(.top, 30).multilineTextAlignment(.center).foregroundColor(ColorManager.secondary)
                
                Spacer()
                
                // Bottom Bar
                HStack {
                    Text("8/8")
                        .padding(.leading, 15)
                        .padding(.bottom, 5)
                        .opacity(0.3)
                    
                    Spacer()
                    
                    Button(action: {
                       self.nextPage = "page7"
                    }) {
                       Image(systemName: "arrow.left.circle.fill")
                       .imageScale(.large)
                       .foregroundColor(ColorManager.primary)
                    }
                    .padding(.trailing, 5)
                    
                    Button(action: {
                        self.showTut = false
                        self.firstTut = false
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(ColorManager.primary)
                                .frame(width:128, height:40)
                                .cornerRadius(20)
                            Text("End Tutorial")
                                .foregroundColor(Color.white)
                        }
                    }
                        .padding(.trailing, 10)
                }
                .padding(.bottom, 5)
                
            }
    
        }.frame(width: 350, height:630)
        .cornerRadius(20).shadow(radius: 20)
    }
}

