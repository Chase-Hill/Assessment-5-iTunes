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
        updateViews()
    }

    // MARK: - Properties
    var songs: [Song] = []
    var album: Album?
    
    // MARK: - Functions
    func updateViews() {
        guard let album = album else { return }
        DispatchQueue.main.async {
            self.albumNameLabel.text = album.albumName
            self.albumArtistLabel.text = album.artistName
        }
        fetchAlbumCover()
        fetchSongs()
    }
    
    func fetchAlbumCover() {
        guard let album = album else { return }
        AlbumService.fetchAlbumCover(forAlbum: album) { [weak self] result in
            switch result {
            case .success(let albumCover):
                DispatchQueue.main.async {
                    self?.albumCoverImageView.image = albumCover
                }
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
    
    func fetchSongs() {
        guard let album = album else { return }
        AlbumService.fetchSongsFromAlbum(fromAlbum: album) { [weak self] result in
            switch result {
            case .success(let songs):
                self?.songs = songs
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else { return UITableViewCell() }
        
        let songs = songs[indexPath.row]
        cell.updateViews(with: songs)
        cell.configureSongNumber(for: indexPath.row)

        return cell
    }
}
