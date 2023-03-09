//
//  SongTableViewCell.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/9/23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var songNumberLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songLengthLabel: UILabel!
    
    // MARK: - Functions
    func updateViews(with song: Song) {
        songNumberLabel.text = "\(song.songNumber)."
        songNameLabel.text = song.songName
        songLengthLabel.text = Converter.millisecondsToMinutesAndSeconds(milliseconds: song.songLength)
    }
}
