//
//  Song.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/8/23.
//

import Foundation

struct SongTopLevel: Decodable {
    
    var results: [Song]
}

struct Song: Decodable {
    private enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case songNumber = "trackNumber"
        case songLength = "trackTimeMillis"
        case songFromAlbumName = "collectionName"
    }
    
    let songName: String
    let songNumber: Int
    let songLength: Int
    let songFromAlbumName: String
}
