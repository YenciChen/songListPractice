//
//  SongTableViewCell.swift
//  songListFromItunesWithAPIPractice
//
//  Created by 陳妍慈 on 2025/3/14.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var singerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(item: SongOfSearchResults,at index: Int) {
        numberLabel.text = "\(index + 1)"
        songNameLabel.text = item.trackName
        singerLabel.text = item.artistName
        songImageView.kf.setImage(with: item.artworkUrl100)
    }
}
