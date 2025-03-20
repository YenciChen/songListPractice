//
//  extension+Son.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/14.
//

import Foundation
import UIKit

extension SongTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch(for: searchBar.text!)
        view.endEditing(true)
    }
        
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            items = []
            tableView.reloadData()
            view.endEditing(true)}
        
    }
}
