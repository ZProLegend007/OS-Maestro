//
//  Onboarding.swift
//  OS Maestro
//
//  Created by Zac Booth on 5/2/24.
//

import SwiftUI

struct Onboarding: View {
    @State private var animate = true // Set initial value to true
    @State private var showButton = false // Control the visibility of the button
    @State private var buttonOpacity = 0.0 // Opacity of the button
    
    let imageNames = ["MacOS", "Win11", "Linux", "chromeOS"] // Array of image names
    
    var body: some View {
        ZStack {
            // Radial gradient to create a background
            RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.black.opacity(10.0)]), center: .center, startRadius: 0, endRadius: 600)
                .edgesIgnoringSafeArea(.all)
            // GeometryReader to get the size of the parent container
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 360, height: 360)
                            .blur(radius: animate ? 50 : 50)
                            .offset(y: animate ? 0 : 0)
                            .blendMode(.overlay)
                            .opacity(animate ? 10.0 : 0)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200) // Adjust the size as needed
                            .zIndex(1)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        HStack(spacing: 30) {
                            ForEach(0..<self.imageNames.count) { index in
                                let imageName = self.imageNames[index] // Explicitly declare index here
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                    .offset(y: animate ? -800 : geometry.size.height / 60 - 130) // Adjusted to start from vertical middle
                                    .offset(x: animate ? 0 : CGFloat(index - 1) * 60) // Adjusted initial x-offset for centering
                                    .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8, initialVelocity: 0).delay(Double(index) * 0.5))
                                    .offset(x: self.animate ? 0 : -26) // Ensure images return to centered position after animation
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    GeometryReader { textGeometry in
                        VStack {
                            Spacer()
                            Text("Welcome to OS Maestro")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, 100) // Adjust padding to position text closer to the bottom
                                .background(
                                    ZStack {
                                        LinearGradient(gradient: Gradient(colors: [Color(hex: 0x003FFF), Color(hex: 0x00FFF0)]), startPoint: .leading, endPoint: .trailing)
                                            .frame(width: textGeometry.size.width * 1, height: 40) // Double the width to make it never-ending
                                            .offset(x: animate ? textGeometry.size.width : 0, y: 0)
                                        LinearGradient(gradient: Gradient(colors: [Color(hex: 0x00FFF0), Color(hex: 0x003FFF)]), startPoint: .leading, endPoint: .trailing)
                                            .frame(width: textGeometry.size.width * 1, height: 40) // Double the width to make it never-ending
                                            .offset(x: animate ? 0 : -textGeometry.size.width, y: 0)
                                    }
                                )
                                .clipShape(Capsule())
                                .mask(Text("Welcome to OS Maestro").font(.title)) // Apply mask to the text
                                .frame(maxWidth: .infinity, alignment: .bottom) // Center horizontally
                                .offset(y: geometry.size.height / 3) // Position at the bottom of the window
                                .offset(y: showButton ? -20 : 0) // Move the text up when the button appears
                                .animation(Animation.easeInOut(duration: 1.0)) // Adjust animation duration
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Align VStack to the bottom
                
                if showButton {
                    // Wrap the Button in a frame to position it at the bottom center of the window
                    Button(action: {
                  // Add animation to Onboarding2
                    }) {
                        Text("Let's get started")
                            .foregroundColor(.white)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                    }
                    .frame(maxWidth: .infinity, alignment: .center) // Center horizontally
                    .offset(y: geometry.size.height / 1.18) // Position at the bottom of the window
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            self.buttonOpacity = self.showButton ? 1 : 0
                        }
                    }
                    .opacity(buttonOpacity)
                }
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 10).repeatForever()) {
                self.animate.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    self.showButton = true
                }
            }
        }
    }
}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

#if DEBUG
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
#endif
