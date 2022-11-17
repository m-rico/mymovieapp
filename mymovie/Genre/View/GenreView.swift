//
//  GenreVC.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation
import UIKit

enum Section: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class GenreView: UIViewController ,AnyView {
    var sectionTitle: [String] = ["Tending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top Rated"]
    var genres = [GenreModel]()
    var movies = [MovieTwo]()
    var presenter: AnyPresenter?
    

    
    private let tableView: UITableView = {
        let tabel = UITableView(frame: .zero, style: .grouped)
        tabel.isHidden = true
        return tabel
    }()
    func update(with genres: [GenreModel]) {
        DispatchQueue.main.async {
            self.genres = genres
            self.tableView.reloadData()
        }
        
    }
    func update(with movies: [MovieTwo]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData()
            //            self.tableView.isHidden = false
        }
        
    }
    func update(with error: String) {
        
    }
    
    func configureNavbar() {
        let label = UILabel()
        label.text = "MyMovieapp"
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(tableView)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = GenreHeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        configureNavbar()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.backgroundColor = .systemBackground
    }
}

//MARK: - Tableview Config
extension GenreView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.genres.count
        //        self.sectionTitle.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return genres[section].name
        //        return sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "Poppins-Medium", size: 17)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = "mricoism"
         cell.backgroundColor = .systemGray6
         return cell
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
            let genId = self.genres[indexPath.section].id ?? 0
            APICaller.shared.getGenreMovie(id: genId) { result in
                switch result {
                case .success(let movieNew):
                    cell.configure(with: movieNew)
                case .failure(let fail):
                    print("genreView \(fail)")
                }
            }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    
}

//MARK: - CollectionView Configure custom delegate
extension GenreView: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailMovieModel) {
        DispatchQueue.main.async { [weak self] in
            /**
             let detailRouter = DetailMovieRouter.start()
             detailRouter.entry?.configure(with: viewModel)
             let toVc = detailRouter.entry
             self?.navigationController?.pushViewController(toVc ?? UIViewController(), animated: true)
             */
            let vc = DetailMovieView()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
}

