//
//  ViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/08.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!

   private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "영화 목록"
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMovieData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
    


}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.popularMovies.count != 0 {
            return viewModel.popularMovies.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
       
       let movie = viewModel.cellForRowAtP(indexPath: indexPath)
       cell.setCellWithValuesOf(movie)
       
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as! DetailViewController
        
        vc.modalTransitionStyle = .coverVertical
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else { return }
        guard let cell: MovieTableViewCell = sender as? MovieTableViewCell else { return }
        
        nextViewController.titleToSet = cell.movieTitle?.text
        nextViewController.dateToSet = cell.movieDate?.text
        nextViewController.posterToSet = cell.urlString
        nextViewController.ratingToSet = cell.movieRate?.text
        nextViewController.overviewToSet = cell.movieOverview?.text
        nextViewController.idToSet = cell.movieID?.text
    }
    
}



