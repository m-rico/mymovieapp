//
//  GenreHeroHeaderView.swift
//  mymovie
//
//  Created by user on 11/11/22.
//

import UIKit

class GenreHeroHeaderView: UIView {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heroDiscover")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let discoverLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Any Genre"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont(name: "Poppins-Bold", size: 34)
        label.textColor = .white
        label.shadowColor = .systemMint
        label.shadowOffset = CGSize(width: 4, height: 4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func applyConstraint() {
        let discoverLabelConstraint = [
            discoverLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            discoverLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            discoverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            discoverLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(discoverLabelConstraint)
    }
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(discoverLabel)
        addGradient()
        applyConstraint()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

