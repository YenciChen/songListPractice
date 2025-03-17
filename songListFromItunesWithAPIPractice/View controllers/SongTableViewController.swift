//
//  SongTableViewController.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/14.
//

import UIKit
import Kingfisher
class SongTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items = [SongOfSearchResults]()
    var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "Search Music"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SongTableViewCell.self)", for: indexPath) as! SongTableViewCell
        let item = items[indexPath.row]
        cell.numberLabel.text = "\(indexPath.row)"
        cell.songNameLabel.text = item.trackName
        cell.singerLabel.text = item.artistName
        cell.songImageView.kf.setImage(with: item.artworkUrl100)
        
        return cell
    }
    
    // MARK: - Navigation
    
    
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //     }
    
    func fetchItem(query: String) {
        
        var processedQuery = query
        if processedQuery.contains("") {
            processedQuery = processedQuery.replacingOccurrences(of: " ", with: "+")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "country", value: "tw"),
            URLQueryItem(name: "term", value: "\(query)")
        ]
        print(urlComponents.url!)
        
        guard let url = urlComponents.url else {
            DispatchQueue.main.async {
                self.showErrorAlert(message: .errorURL)
            }
            return
        }
   
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    self.showErrorAlert(message: .networkError)
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.showErrorAlert(message: .invalidResponse)
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    self.showErrorAlert(message: .serverError)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let item = try decoder.decode(ItunesSearchResponse.self, from: data)
                self.items = item.results
                if self.items.isEmpty == false {
                    print("noData")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.showErrorAlert(message: .decodingError )
                }
            }
        }.resume()
    }
    
    func showErrorAlert(message: ITunesSearchError ) {
        
        print(message)
        let alert = UIAlertController(title: "錯誤", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default))
        present(alert, animated: true)
    }
}


