//
//  SearchError.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/15.
//

import Foundation

enum ITunesSearchError: String,Error {
    case errorURL = "網址錯誤"
    case networkError = "網路連接問題"
    case noData = "無資料"
    case invalidResponse  = "response有問題"
    case decodingError  = "解析有問題"
    case serverError  = "伺服器問題"
}
