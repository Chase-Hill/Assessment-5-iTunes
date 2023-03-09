//
//  Album.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/6/23.
//

import UIKit

struct AlbumTopLevel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    let results: [Album]
}

struct Album: Decodable {
    private enum CodingKeys: String, CodingKey {

        case albumName = "collectionName"
        case albumCover = "artworkUrl100"
        case songCount = "trackCount"
    }
    
    let albumName: String
    let albumCover: String
    let songCount: Int
}
