//
//  MovieViewModel.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/14.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    var popularMovies = [Movie]()
    var similarMovies = [SMovie]()
    
    func fetchPopularMovieData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData{ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    
    }
    func fetchSimilarMovieData(completion: @escaping () -> ()) {
        
        apiService.getSimilarMovieData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.similarMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    
    }
    
    func numberOfRowsInSectionP(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAtP (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
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
    
}
