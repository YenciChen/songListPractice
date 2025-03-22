//
//  SongTableViewController.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/14.
//

import UIKit
import Kingfisher
import AVFoundation

class SongTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items = [SongOfSearchResults]()
    let player = AVPlayer()
    
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
        cell.configureCell(item: item, at: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation
    
    func performSearch(for queryname: String) {
        
        Task {
            do {
                let itune = ITunesNetworkService()
                let results = try await itune.fetchItem(query: queryname)
                print(results)
                self.items = results
                
                self.tableView.reloadData()
            }catch  {
                print(error)
            }
        }
        
    }
    func showErrorAlert(message: ITunesSearchError) {
        
        print(message)
        let alert = UIAlertController(title: "錯誤", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確定", style: .default))
        self.present(alert, animated: true)
        
    }
    
    @IBAction func playSong(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
//            let item = items[indexPath.row]
//            let playeritem = AVPlayerItem(url: item.previewUrl)
//            player.replaceCurrentItem(with: playeritem)
//            player.play()
        }
    }
}









