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
        let albumQuery = URLQueryItem(name: Constants.AlbumsURL.queryKey, value: searchTerm)
        urlComponents?.queryItems = [albumQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Final Album URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Album Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                
                let album = try JSONDecoder().decode(TopLevel.self, from: data)
                completion(.success(album))
            } catch {
                
                completion(.failure(.unableToDecode)) ; return
            }
        } .resume()
    }
}
