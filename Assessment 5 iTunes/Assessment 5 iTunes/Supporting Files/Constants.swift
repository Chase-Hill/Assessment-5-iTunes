//
//  Constants.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/6/23.
//

import Foundation

struct Constants {
    
    //https://itunes.apple.com/search?entity=album&limit=25&term=(searchTerm)
    //https://itunes.apple.com/lookup?entity=song&id=(searchTermID)
    struct AlbumsURL {
        
        static let baseURL = "https://itunes.apple.com/"
        static let searchPath = "search"
        static let queryKey1 = "entity"
        static let queryValue1 = "album"
        static let queryKey2 = "term"
    }
    
    struct SongsURL {
        
        static let baseURL = "https://itunes.apple.com/lookup?entity=song"
        static let queryKey = "id"
    }
}
