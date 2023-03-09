//
//  SongListTableViewController.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/8/23.
//

import UIKit

class SongListTableViewController: UITableViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var album: Album?
    var songs: [Song] = []
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        // Configure the cell...

        return cell
    }
}
