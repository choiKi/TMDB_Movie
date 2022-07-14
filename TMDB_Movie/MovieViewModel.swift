//
//  MovieViewModel.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/14.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var popularMoviews = [Movie]()
    
    func fetchPopularMovieData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData{ [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMoviews = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            
        }
    
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMoviews.count != 0 {
            return popularMoviews.count
        }
        return 0
    }
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMoviews[indexPath.row]
    }
}
