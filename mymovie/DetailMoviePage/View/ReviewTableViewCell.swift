//
//  ReviewTableViewCell.swift
//  mymovie
//
//  Created by user on 16/11/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    static let identifier = "reviewTableViewCell"
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 12)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 17)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reviewLabel)
        applyConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func applyConstraint() {
        let userNameLabelConstraints = [
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 24),
        ]
        NSLayoutConstraint.activate(userNameLabelConstraints)
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ]
        NSLayoutConstraint.activate(dateLabelConstraints)
        let reviewLabelConstraints = [
            reviewLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            reviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            reviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            reviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(reviewLabelConstraints)
    }
    
    func configure(name: String, date: String, review: String) {
        self.userNameLabel.text = name
        self.dateLabel.text = date
        self.reviewLabel.text = review
    }
    
    
}
