//
//  SimilarMovieTableViewCell.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/16.
//

import UIKit

class SimilarMovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    var urlString: String = ""
    
    func setCellWithValuesOf(_ movie: SMovie) {
        updateUI(title: movie.title, rating: movie.rate, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, rating: Double?, poster: String?) {
        
        self.movieTitle.text = title
        guard let rate = rating else {return}
        self.movieRating.text = String(rate)
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.moviePoster.image = nil
        
        getImageDataFrom(url: posterImageURL)
         
    }
    func genreString(_ movie: SMovie) {
        
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
}
