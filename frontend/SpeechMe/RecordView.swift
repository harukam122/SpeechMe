//
//  RecordView.swift
//  SpeechMe
//
//  Created by Haruka Masamura on 10/15/22.
//

import SwiftUI

// creating audio recorder

struct RecordView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.3216, green: 0.3247, blue: 0.87).opacity(0.1)
                Text("Hello, Second View!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.3216, green: 0.3247, blue: 0.3538))
            }
            ZStack {
                Color(red: 0.3216, green: 0.3247, blue: 0.87).opacity(0.1)
                Text("Hello, Second View!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color(red: 0.3216, green: 0.3247, blue: 0.3538))
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
