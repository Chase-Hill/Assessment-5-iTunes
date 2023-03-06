//
//  NetworkingController.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/6/23.
//

import Foundation

struct AlbumService {
    
    static func fetchAlbums(forTerm searchTerm: String, completion: @escaping (Result<TopLevel, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.AlbumsURL.baseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let 
    }
}
