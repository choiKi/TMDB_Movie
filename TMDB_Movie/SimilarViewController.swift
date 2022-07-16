//
//  SimilarViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/16.
//

import UIKit

class SimilarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    var titleToSet2 : String?
    var posterToSet2 : String?
    var idToSet2: String?
    var ratingToSet2 : String?
    
    var linkID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "비슷한 영화"
        // Do any additional setup after loading the view.
        linkID = idToSet2!
        loadSimilarMoviesData()
    }
    
    private func loadSimilarMoviesData() {
        viewModel.fetchSimilarMovieData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    
    
    
}

extension SimilarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.similarMovies.count != 0 {
            return viewModel.similarMovies.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sCell", for: indexPath) as! SimilarMovieTableViewCell
        
        let movie = viewModel.cellForRowAtS(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    
}
