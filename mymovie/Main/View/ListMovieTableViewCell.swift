//
//  ListMovieTableViewCell.swift
//  mymovie
//
//  Created by user on 14/11/22.
//

import UIKit
import SDWebImage


protocol ListMovieTableViewCellDelegate: AnyObject {
    func ListMovieTableViewCellDidTapCell(_ cell: MainViewController, videoModel: DetailMovieModel)
}

class ListMovieTableViewCell: UITableViewCell {

    static let identifier = "listMovieTableViewCell"
    
    weak var delegate: ListMovieTableViewCellDelegate?
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let voteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imagePosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imagePosterView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(voteLabel)
        applyConstraints()
    }
    private func applyConstraints() {
        let imagePosterViewConstraints = [
//            imagePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imagePosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imagePosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//            imagePosterView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imagePosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imagePosterView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(imagePosterViewConstraints)
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: imagePosterView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        let releaseDateLabelConstraints = [
            releaseDateLabel.leadingAnchor.constraint(equalTo: imagePosterView.trailingAnchor, constant: 16),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ]
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
        let voteLabelConstraints = [
            voteLabel.leadingAnchor.constraint(equalTo: imagePosterView.trailingAnchor, constant: 16),
            voteLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(voteLabelConstraints)
    }
    
    
    public func configure(with model: MainViewModel) {
//        guard let url = URL(string: model.posterUrl) else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {return}
//        print("finland \(url)")
        self.imagePosterView.sd_setImage(with: url, completed: nil)
        self.titleLabel.text = model.titleName
        self.releaseDateLabel.text = model.releaseDate
        self.voteLabel.text = "Vote average: \(model.votedAverage) \u{2605}"
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
