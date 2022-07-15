//
//  ApiService.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/08.
//

import Foundation


class ApiService {
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void ) {
        let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&language=ko-KR&page=1"
        
        guard let url = URL(string: popularMovieURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
    
            if let error = error {
                completion(.failure(error))
                print("DataTask error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let data = data else {
                print("empty data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()

    }

    func getSimilarMovieData(completion: @escaping (Result<MoviesData, Error>) -> Void ) {
        
        let similarMovieURL = "https://api.themoviedb.org/3/movie/438148/similar?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&language=ko-KR&page=1"
        
        guard let url = URL(string: similarMovieURL) else { return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error ) in
            if let error = error {
                completion(.failure(error))
                print("DataTask error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let data = data else {
                print("empty data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
    
