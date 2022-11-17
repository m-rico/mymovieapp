//
//  MovieCollectionViewCell.swift
//  mymovie
//
//  Created by user on 14/11/22.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "movieCollectionViewCell"
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {return}
        self.posterImageView.sd_setImage(with: url, completed: nil)
//        let url = "https://image.tmdb.org/t/p/w500\(model)"
//        self.posterImageView.load(urlString: url)
    }
}
