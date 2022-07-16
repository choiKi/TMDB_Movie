//
//  DetailViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var idView: UILabel!
    
    var titleToSet: String?
    var dateToSet: String?
    var posterToSet: String?
    var ratingToSet: String?
    var overviewToSet: String?
    var idToSet: String?
    
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailSet()
        print(idToSet!)
        navigationItem.title = "세부 정보"
        
        // Do any additional setup after loading the view.
    }
    
    private func detailSet() {
        
        movieTitle.text = titleToSet
        movieRating.text = "평점: \(ratingToSet!)"
        movieOverview.text = overviewToSet
        movieDate.text = "개봉일: \(dateToSet!)"
        idView.text = idToSet
        
        guard let posterString = posterToSet else {return}
        
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        guard let posterImageURL = URL(string: urlString) else {
            self.moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        self.moviePoster.image = nil
        getImageDataFrom(url: posterImageURL)
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
    

    @IBAction func searchSimilarMovie(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "similar") as! SimilarViewController

        vc.idToSet2 = idToSet
        vc.titleToSet2 = titleToSet
        vc.posterToSet2 = posterToSet
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    

}
