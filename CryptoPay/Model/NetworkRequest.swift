//
//  NetworkRequest.swift
//  CryptoPay
//
//  Created by JamesJoseph Burch on 6/6/20.
//  Copyright © 2020 James Burch. All rights reserved.
//

import Foundation

class NetworkRequests {
   //let defaultSession = URLSession(configuration: .default)
   var errorMessage: String?
   var results: Data?
   typealias Results = (Data, String) -> Void
    func getSearchResults(_ searchTerm: String, completion: @escaping Results) {
        let SearchRequest = "https://cryptopay.jamesjosephburch.com" + searchTerm
        let url = URL(string: SearchRequest)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(APIkey, forHTTPHeaderField: "X-Api-Key")
        let Task: URLSessionDataTask =
         URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
         if let error = error {
           self?.errorMessage! += "DataTask error: " +
                                   error.localizedDescription + "\n"
         } else if
           let data = data,
           let response = response as? HTTPURLResponse,
           response.statusCode == 200 {
           //self?.results = data
           DispatchQueue.main.async {
               completion(data, self?.errorMessage ?? "")
           }
         }
        }
        Task.resume()
   }
}
