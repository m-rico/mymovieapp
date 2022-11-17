//
//  CollectionViewTableViewCell.swift
//  mymovie
//
//  Created by user on 11/11/22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate:AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailMovieModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "collectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var movies: [MovieTwo] = [MovieTwo]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with movies: [MovieTwo]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - CollectionView Config

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath)
//        cell.backgroundColor = .systemGray5
//        return cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return UICollectionViewCell()}
        guard let model = self.movies[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count - 14
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        guard let movieId = movie.id else {return}
        APICaller.shared.getMovieToo(with: movieId) { [weak self] result in
            
            switch result {
            case .success(let video):
                
                guard let movieOverview = movie.overview else {
                    return
                }
//                print("newzeland\(self?.movies)")
                guard let strongSelf = self else {
                    return
                }
                
                
//                let viewModel = DetailMovieModel(title: movie.title, youtubeView: video, overview: movieOverview)
                let viewModel = DetailMovieModel(id: movie.id, title: movie.title, youtubeView: video, overview: movieOverview)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
                
            case .failure(let fail):
                print("mainViewFAIL \(fail.localizedDescription)")
            }
        }
    }
    
}
