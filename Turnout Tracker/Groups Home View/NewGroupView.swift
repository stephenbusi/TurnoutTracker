//
//  NewGroupView.swift
//  Turnout Tracker
//
//  Created by Stephen Boussarov on 7/15/20.
//  Copyright © 2020 Stephen Boussarov. All rights reserved.
//

import SwiftUI

struct NewGroupView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var text:String = ""
    
    @State private var showImage = false
    @State private var inputImage: UIImage?
    
    @State private var image: Image?
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        VStack {
            // Title
            Text("Create New Group")
                .font(thisFont(size:40)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top,75)
            
            // New List Name
            VStack(alignment: .leading){
                Text("Group Name")
                    .font(thisFont(size:15)).foregroundColor(Color.gray).offset(y: 5)
                TextField("Enter Group Name",text: $text)
                    .font(thisFont(size: 15)).textFieldStyle(RoundedBorderTextFieldStyle()).accentColor(.gray)
            }.padding(.horizontal,50).padding(.top,30)
            
            /* ZStack {
                Rectangle()
                    .fill(ColorManager.secondary)
                if image != nil {
                    
                    self.image?
                    .resizable()
                    .scaledToFit()
                } else {
                    Text("YELLOW")
                }
            }
            
            Button(action: {
                self.showImage = true
            }) {
                Text("add Image")
            } */
            

            Spacer()
            
            // Create Button
            Button(action: {
                
                // Only creates group if it has name
                if self.text != "" {
                    let group = Group(context: self.managedObjectContext)
                    group.name = self.text
                    
                    
                    
                    // try to save
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                    
                }
                
                UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                
            }) {
                ZStack {
                    Rectangle()
                        .fill(ColorManager.primary)
                        .cornerRadius(25)
                        .frame(width:150,height:50)
                        .shadow(color: Color.black.opacity(0.3),radius: 3,x: 3,y: 3)
                    Text("   CREATE   ")
                        .font(.system(size: 20)).bold()
                        .foregroundColor(Color.white)
                        .frame(alignment: .center)
                }
            }.padding(.bottom, 50)
            

        } // end VStack
            .navigationBarTitle("", displayMode: .inline)
            .sheet(isPresented: $showImage, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
    }
}
