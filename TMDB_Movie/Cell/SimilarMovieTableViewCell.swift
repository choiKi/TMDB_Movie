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
    @IBOutlet weak var movieGenre: UILabel!
    
    var urlString: String = ""
    
    func setCellWithValuesOf(_ movie: SMovie) {
        updateUI(title: movie.title, rating: movie.rate, poster: movie.posterImage, genre: movie.genre!)
    }
    
    private func updateUI(title: String?, rating: Double?, poster: String?, genre: [Int]) {
        
        self.movieTitle.text = title
        guard let rate = rating else {return}
        self.movieRating.text = String(rate)
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        let genreInt = genre
        var genreString = [String]()
        for index in 0 ..< genreInt.count {
            switch genreInt[index] {
            case 28:
                genreString.append("액션")
            case 12:
                genreString.append("모험")
            case 14:
                genreString.append("판타지")
            case 16:
                genreString.append("애니메이션")
            case 18:
                genreString.append("드라마")
            case 27:
                genreString.append("공포")
            case 35:
                genreString.append("코미디")
            case 36:
                genreString.append("역사")
            case 37:
                genreString.append("서부")
            case 53:
                genreString.append("스릴러")
            case 80:
                genreString.append("범죄")
            case 99:
                genreString.append("다큐멘터리")
            case 878:
                genreString.append("SF")
            case 9648:
                genreString.append("미스터리")
            case 10402:
                genreString.append("음악")
            case 10749:
                genreString.append("로맨스")
            case 10751:
                genreString.append("가족")
            case 10752:
                genreString.append("전쟁")
            case 10770:
                genreString.append("TV 영화")
            default:
                genreString.append("-")
            }
        }
        var genreText = genreString.joined(separator: ", ")
        self.movieGenre.text = genreText
    
        
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
