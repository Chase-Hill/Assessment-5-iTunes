//
//  AlbumSearchTableViewController.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/5/23.
//

import UIKit

class AlbumSearchTableViewController: UITableViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var albums: [Album] = []
    var albumTopLevel: AlbumTopLevel?
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }

        let album = albums[indexPath.row]
        cell.fetchAlbums(for: album)

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongListVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? SongListTableViewController else { return }
            let album = albums[indexPath.row]
            destinationVC.album = album
        }
    }
}

extension AlbumSearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        AlbumService.fetchAlbums(forTerm: searchTerm) { [weak self] result in
            switch result {
            case .success(let topLevel):
                self?.albumTopLevel = topLevel
                self?.albums = topLevel.results
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
