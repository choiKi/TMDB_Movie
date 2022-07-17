//
//  SimilarModel.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/17.
//

import Foundation

class SimilarModel {

    /*
    private var dataTask: URLSessionDataTask?
    
    var similarMovies = [SMovie]()
    
    func getSimilarMovieData(completion: @escaping (Result<SMoviesData, Error>) -> Void ) {
        
        let similarMovieURL = "https://api.themoviedb.org/3/movie/438223/similar?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&language=ko-KR&page=1"
        
        let similarMovieURL1 = "https://api.themoviedb.org/3/movie/"
        let similarMovieURL2 = "/similar?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&language=ko-KR&page=1"
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
                let jsonData = try decoder.decode(SMoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func fetchSimilarMovieData(completion: @escaping () -> ()) {
        
        getSimilarMovieData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.similarMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    
    }
    
    func numberOfRowsInSectionS(section: Int) -> Int {
        if similarMovies.count != 0 {
            return similarMovies.count
        }
        return 0
    }
    
    func cellForRowAtS (indexPath: IndexPath) -> SMovie {
        return similarMovies[indexPath.row]
    }
     */
    
}
