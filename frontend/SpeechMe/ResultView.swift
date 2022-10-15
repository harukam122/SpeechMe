//
//  ResultView.swift
//  SpeechMe
//
//  Created by Haruka Masamura on 10/15/22.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ResultView: View {
    @State private var results = [Result]()
    
    var body: some View {
        
        // view code
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.white)
                Text("97")
                    .foregroundColor(Color.accentColor)
                    .font(.largeTitle.bold())
//                List(results, id: \.trackId) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.trackName)
//                            .font(.headline)
//                        Text(item.collectionName)
//                    }
//                }
            }
            .background(Color.accentColor)
            .task {
                await loadResult()
            }
        }
    }
    
    func loadResult() async {
        guard let url = URL(string: "http://www.randomnumberapi.com/api/v1.0/random?min=1&max=100&count=1") else {
            print("Invalid URL")
            return
        }
        
        // retrieve data (toss meta data)
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid Data")
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
