//
//  ApiController.swift
//  IOS-Project
//
//  Created by admin on 5/17/24.
//

import Foundation


// Data Model for Joke

struct Joke: Codable, Identifiable {

    let id: Int

    let type: String

    let setup: String

    let punchline: String

}



func apiRequest(endpoint:String) async {
    
    var output:String
    guard let url = URL(string: "http://127.0.0.1:5000/api/\(endpoint)") else { return  }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)

        
        if let decodedCommand = try? JSONDecoder().decode(String.self, from: data){
            output = decodedCommand
            
            print(output)
        }
    }
    catch{
        print("Error fetching joke: \(error)")
    }
    
//    return joke
}
