//
//  AlbumTableViewCell.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/6/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songsInAlbumLabel: UILabel!
    
    // MARK: - Functions
    func fetchAlbums(for album: Album) {
        
        albumNameLabel.text = album.albumName
        songsInAlbumLabel.text = "\(album.songCount) Songs"
        AlbumService.fetchAlbumCover(forAlbum: album) { [weak self] result in
            switch result {
            case .success(let cover):
                
                DispatchQueue.main.async {
                    self?.albumCoverImageView.image = cover
                }
            case .failure(let error):
                
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
