//
//  SearchBarTableViewCell.swift
//  TMDB_Movie
//
//  Created by 최기훈 on 2022/07/20.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    // @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "SearchCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchBarTableViewCell", bundle: nil)
    }
    
    func configure(with model: SearchMovie) {
        self.title.text = model.title
        
        let url = model.image
        let data = try! Data(contentsOf: URL(string: url)!)
        //self.poster.image = UIImage(data: data)
        
    }

    
}
