//
//  SearchTableViewCell.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/20.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "SearchCell"
    


    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    func configure(with model: SearchMovie) {
        self.title.text = model.name
        
        let url = "https://image.tmdb.org/t/p/w300" + model.logo_path
        let data = try! Data(contentsOf: URL(string: url)!)
        
        self.poster.image = UIImage(data: data)
    }

    
}
