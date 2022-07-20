//
//  SearchViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/20.
//

import UIKit
import Foundation

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var string: String?

    var searchAPI = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func showSearch() {
        
        guard let string = string else {
            return
        }
        searchAPI = "https://api.themoviedb.org/3/search/company?api_key=1a8a16f83fbed96908c36d0c9ffc8f74&query=\(string)&page=1"
        
    }

}

