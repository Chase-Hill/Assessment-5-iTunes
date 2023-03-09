//
//  SongListTableViewController.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/8/23.
//

import UIKit

class SongListTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistLabel: UILabel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var song: Song?
    var album: Album?
    var songs: [Song] = []
    
    // MARK: - Functions
    func updateViews() {
        guard let album = album else { return }
        guard let song = song else { return }
        albumNameLabel.text = album.albumName
        albumArtistLabel.text = song.songArtistName
        
        AlbumService.fetchAlbumCover(forAlbum: album) { [weak self] result in
            switch result {
            case .success(let album):
                <#code#>
            case .failure(let error):
                <#code#>
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        let song = songs[indexPath.row]
        cell.updateViews(with: song)

        return cell
    }
}
