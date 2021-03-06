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
    //  private var similarModel = SimilarModel()
    
    var titleToSet2 : String?
    var posterToSet2 : String?
    var idToSet2: String?
    var ratingToSet2 : String?
    
    var linkID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "유사한 영화"
        self.navigationItem.largeTitleDisplayMode = .always
        
        
        print(idToSet2!)
        // Do any additional setup after loading the view.
        loadSimilarMoviesData()
    }
    
    private var dataTask: URLSessionDataTask?
    
    var similarMovies = [SMovie]()
    
    func getSimilarMovieData(completion: @escaping (Result<SMoviesData, Error>) -> Void ) {
        
        let similarMovieURL1 = "https://api.themoviedb.org/3/movie/"
        let similarMovieURL2 = "/similar?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&language=ko-KR&page=1"
        let similarMovieURL = "\(similarMovieURL1)\(idToSet2!)\(similarMovieURL2)"
        
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
    
    private func loadSimilarMoviesData() {
            self.fetchSimilarMovieData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    
    
}

extension SimilarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if similarMovies.count != 0 {
            return similarMovies.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sCell", for: indexPath) as! SimilarMovieTableViewCell
        
        let movie = cellForRowAtS(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
    
}
