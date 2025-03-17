//
//  Item.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/14.
//

import Foundation
struct ItunesSearchResponse:Codable {
    let resultCount: Int
    let results: [SongOfSearchResults]
    
}
struct SongOfSearchResults: Codable {
    let artistName: String
    let trackName: String
    let previewUrl: URL
    let artworkUrl100: URL
}
