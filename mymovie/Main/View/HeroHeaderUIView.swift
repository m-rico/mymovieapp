//
//  HeroHeaderUIView.swift
//  mymovie
//
//  Created by user on 11/11/22.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {
    
    private let infoButton: UIButton = {
        let infoButton = UIButton()
//        infoButton.tintColor = .black
        infoButton.setTitleColor(.label, for: .normal)
        infoButton.setTitle("Info", for: .normal)
        infoButton.layer.borderColor = UIColor.label.cgColor
        infoButton.layer.borderWidth = 1
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.layer.cornerRadius = 5
//        infoButton.tintColor = .systemGray5
        return infoButton
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "terrifierTwo")
        return imageView
    }()
    
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    func applyConstraint() {
        let infoButtonConstraint = [
//            infoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            infoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            infoButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(infoButtonConstraint)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        addSubview(infoButton)
        applyConstraint()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: MovieTwo) {
        print("swiszerlan \(String(describing: model.poster_path) ?? "")")
        let tempImage = model.poster_path ?? ""
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(tempImage)") else {return}
        
        self.imageView.sd_setImage(with: url, completed: nil)
    }

}
