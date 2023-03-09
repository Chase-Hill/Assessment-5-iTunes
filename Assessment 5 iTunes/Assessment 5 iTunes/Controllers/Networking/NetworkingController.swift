//
//  NetworkingController.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/6/23.
//

import UIKit

class AlbumService {
    
    static func fetchAlbums(forTerm searchTerm: String, completion: @escaping (Result <AlbumTopLevel, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.AlbumsURL.baseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.AlbumsURL.searchPath)
        let albumQuery1 = URLQueryItem(name: Constants.AlbumsURL.queryKey1, value: Constants.AlbumsURL.queryValue1)
        let albumQuery2 = URLQueryItem(name: Constants.AlbumsURL.queryKey2, value: searchTerm)
        urlComponents?.queryItems = [albumQuery1, albumQuery2]
        
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
                
                let album = try JSONDecoder().decode(AlbumTopLevel.self, from: data)
                completion(.success(album))
            } catch {
                
                completion(.failure(.unableToDecode)) ; return
            }
        } .resume()
    }
    
    static func fetchAlbumCover(forAlbum album: Album, completion: @escaping (Result <UIImage, NetworkError>) -> Void) {
        
        guard let imageURL = URL(string: album.albumCover) else { completion(.failure(.invalidURL)) ; return }
        print("Final Image URL: \(imageURL)")
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Image Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            guard let cover = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
            completion(.success(cover))
        } .resume()
    }
    
    static func fetchSongsFromAlbum(fromAlbum album: Album, completion: @escaping (Result <SongTopLevel, NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.SongsURL.baseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.SongsURL.searchPath)
        let songQuery1 = URLQueryItem(name: Constants.SongsURL.queryKey1, value: Constants.SongsURL.queryValue1)
        let songQuery2 = URLQueryItem(name: Constants.SongsURL.queryKey2, value: album.albumName)
        urlComponents?.queryItems = [songQuery1, songQuery2]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Final Song List URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Song List Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                
                let songs = try JSONDecoder().decode(SongTopLevel.self, from: data)
                completion(.success(songs))
            } catch {
                
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
}
