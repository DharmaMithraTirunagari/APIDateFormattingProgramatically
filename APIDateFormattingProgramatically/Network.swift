//
//  Network.swift
//  APIDateFormattingProgramatically
//
//  Created by Srikanth Kyatham on 12/3/24.
//

import Foundation

class Network:@unchecked Sendable {
    static let sharedInstance = Network()
    private init(){}
    
    func getData(from url: String, completion: @escaping (PersonModel?) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(nil)
                return
            }
            do {
                let receivedData = try JSONDecoder().decode(PersonModel.self, from: data)
                print(receivedData)
                completion(receivedData)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
