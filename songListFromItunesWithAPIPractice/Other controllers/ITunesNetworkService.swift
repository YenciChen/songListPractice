//
//  NetworkController.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/17.
//

import Foundation

class ITunesNetworkService {
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
    
    func fetchItem(query: String) async throws -> [SongOfSearchResults] {
        
        var processedQuery = query
        if processedQuery.contains(" ") {
            processedQuery = processedQuery.replacingOccurrences(of: " ", with: "+")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "country", value: "tw"),
            URLQueryItem(name: "term", value: "\(processedQuery)")
        ]
        
        guard let url = urlComponents.url else {
            throw ITunesSearchError.errorURL
        }
        print("Now Your Search URL is: \(url)")
        
            let (data, response) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(ItunesSearchResponse.self, from: data)
            print(searchResponse)
        
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw  ITunesSearchError.invalidResponse
            }
            
            guard searchResponse.results.isEmpty == false  else {
                print("nodata")
                throw ITunesSearchError.noData
            }
            return searchResponse.results
        }
    }
    
   
