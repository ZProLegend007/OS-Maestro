//
//  Onboarding2.swift
//  OS Maestro
//
//  Created by Zac Booth on 5/2/24.
//

import SwiftUI

struct Onboarding2: View {
    var body: some View {
        ZStack {
            // Radial gradient to create a background
            RadialGradient(gradient: Gradient(colors: [Color.blue.opacity(1), Color.blue.opacity(10.0)]), center: .center, startRadius: 0, endRadius: 600)
                .edgesIgnoringSafeArea(.all)

        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Onboarding2()
}
