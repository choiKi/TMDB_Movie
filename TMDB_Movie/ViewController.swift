//
//  ViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

   private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMovieData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.numberOfRowsInSection(section: section)
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
       
       let movie = viewModel.cellForRowAt(indexPath: indexPath)
       cell.setCellWithValuesOf(movie)
       
       return cell
   }
}



