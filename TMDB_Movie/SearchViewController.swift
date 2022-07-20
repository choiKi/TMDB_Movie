//
//  SearchViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/20.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [SearchMovie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchBarTableViewCell.nib(), forCellReuseIdentifier: SearchBarTableViewCell.identifier)
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func searchMovie() {
        
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        text.replacingOccurrences(of: " ", with: "%")
        movies.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://imdb-api.com/en/API/SearchMovie/k_aj01p20o/\(text)")!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                return
            }
            var results: MovieResult?
            do {
                results = try JSONDecoder().decode(MovieResult.self, from: data)
            }
            catch {
                print("error  \(error)")
            }
            guard let finalResult = results else {
                return
            }
            let fmovies = finalResult.results
            self.movies.append(contentsOf: fmovies)
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }).resume()
        print(text)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovie()
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.identifier, for: indexPath) as! SearchBarTableViewCell
        
        cell.configure(with: movies[indexPath.row])
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   

}

struct MovieResult: Codable {
    let results: [SearchMovie]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
}

struct SearchMovie: Codable{
    let image: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case title,image
    }
}
