//
//  MovieTableViewCell.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/14.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieID: UILabel!
    @IBOutlet weak var movieDate: UILabel!

    var urlString: String = ""
    
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(id: movie.id, title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(id: Int?, title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        
        self.movieTitle.text = title
        guard let rate = rating else {return}
        guard let id = id else {return}
        self.movieID.text = String(id)
        self.movieDate.text = releaseDate
        self.movieRate.text = String(rate)
        self.movieOverview.text = overview
        
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
    
    // MARK: - Get image data
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
