//
//  ContentView.swift/Users/harukamasamura/Desktop/cs/SpeechMe/SpeechMe/ContentView.swift
//  SpeechMe
//
//  Created by Haruka Masamura on 10/14/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            // view code
            VStack(alignment: .center) {
                Spacer()
                
                Image("speechme").resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    
                Text("Welcome")
                    .padding()
                    .font(Font.custom("KumbhSans-SemiBold", size: 40))
                    .foregroundColor(Color.accentColor)
                
                Spacer()
                
                // Get Started Button
                NavigationLink("Get Started") {
                    InputView()
                }
                .font(Font.custom("KumbhSans-SemiBold", size: 20))
                .padding()
                .background(Color("AccentColor"))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
