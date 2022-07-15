//
//  SimilarViewController.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/16.
//

import UIKit

class SimilarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    
    var titleToSet2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTitle.text = "\(titleToSet2)와 비슷한 영화"
        // Do any additional setup after loading the view.
    }
    

    

}
