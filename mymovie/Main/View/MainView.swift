//
//  MainView.swift
//  mymovie
//
//  Created by user on 09/11/22.
//
//  ViewController
//  Protocol
//  refrence Presenter

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with movies: [MovieTwo])
    func update(with genres: [GenreModel])
    func update(with error: String)
    func configure(with model: DetailMovieModel)
}



class MainViewController: UIViewController, AnyView {
    
    private var randomTrendingMovie: MovieTwo?
    private var headerView: HeroHeaderUIView?
    
    var presenter: AnyPresenter?
    var movies: [MovieTwo] = [MovieTwo]()
    var page = 2
    var morePage = true
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ListMovieTableViewCell.self,
                       forCellReuseIdentifier: ListMovieTableViewCell.identifier)
        //        table.register(UITableViewCell.self,
        //                       forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    private let labelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(labelView) /// This is make problem for navigation if placed above view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        tableView.tableHeaderView = headerView
        //        tableView.tableHeaderView.configure
        //UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        configureNavbar()
        self.configureHeroHeaderView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        labelView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        labelView.center = view.center
        
    }
    
    func configureNavbar() {
        let titleLabel = UILabel()
        titleLabel.text = "MyMovieapp"
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        let LabelItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.leftBarButtonItem = LabelItem
        
        let imageUser = UIImage(systemName: "person.crop.circle")
        imageUser?.withRenderingMode(.alwaysTemplate)
        let rightBarItem = UIBarButtonItem(image: imageUser, style: .done, target: self, action: nil)
        //        rightBarItem.tintColor = .label
        navigationItem.rightBarButtonItem = rightBarItem
        navigationController?.navigationBar.tintColor = .label
    }
    func update(with movies: [MovieTwo]) {
        DispatchQueue.main.async {
            print("INDIAAAAAA")
            self.movies = movies
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.movies = []
            self.labelView.isHidden = false
            self.labelView.text = error
            self.tableView.isHidden = true
            
        }
    }
    
    private func configureHeroHeaderView() {
        print("swiszerlan 1")
        DispatchQueue.main.async {
            guard let selectedMovie = self.movies.randomElement() else {return}
            self.randomTrendingMovie = selectedMovie
            self.headerView?.configure(with: selectedMovie)
        }
        
    }
}

//MARK: - ConfigureTableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = movies[indexPath.row].title
         cell.textLabel?.font = UIFont(name: "Poppins-Regular", size: 17)
         return cell
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTableViewCell.identifier, for: indexPath) as? ListMovieTableViewCell else { return UITableViewCell()
        }
        let tempMov = self.movies[indexPath.row]
        cell.configure(with: MainViewModel(titleName: tempMov.title ?? "unknown movie", posterUrl: tempMov.poster_path ?? "", votedAverage: tempMov.vote_average ?? 0 , releaseDate: tempMov.release_date ?? "soon"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        guard let movieId = movie.id else {return}
        APICaller.shared.getMovieToo(with: movieId) { [weak self] result in
            switch result {
            case .success(let video):
                
                guard let movieOverview = movie.overview else {
                    return
                }
                //                print("mainViewGOOD \(video), \(movieOverview)")
                
                DispatchQueue.main.async {
                    //                    let viewModel = DetailMovieModel(title: movie.title, youtubeView: video, overview: movieOverview)
                    let viewModel = DetailMovieModel(id: movie.id, title: movie.title, youtubeView: video, overview: movieOverview)
                    /**
                     let detailRouter = DetailMovieRouter.start()
                     detailRouter.entry?.configure(with: viewModel)
                     let toVc = detailRouter.entry
                     self?.navigationController?.pushViewController(toVc ?? UIViewController(), animated: true)
                     */
                    let vc = DetailMovieView()
                    vc.configure(with: viewModel)
                    self?.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
                }
                
            case .failure(let fail):
                print("mainViewFAIL \(fail.localizedDescription)")
            }
        }
        
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
        let currentOffset = self.tableView.contentOffset.y
        let maximumOffset = self.tableView.contentSize.height - self.tableView.frame.height

        if maximumOffset - currentOffset <= 100.0 {
            print("china")
            
            guard !APICaller.shared.isPaginating else {
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
                APICaller.shared.getMovieMore(page: self.page, paginating: true, preMov: self.movies) { [weak self] result in
                        switch result {
                        case .success(let newMovies):
                            
                            self?.movies.append(contentsOf: newMovies)
                            DispatchQueue.main.async {
                                self?.tableView.tableFooterView = nil
                                self?.tableView.isHidden = false
                                self?.tableView.reloadData()
                            }
                            self?.morePage = true
                            self?.page += 1
                        case .failure(let error):
                            print(error)
                        }
                    
//                }
            }
        }
    }
}

//MARK: - AnyExtention

extension AnyView {
    func update(with movies: [MovieTwo]) {}
    func update(with movies: [GenreModel]) {}
    func update(with error: String) {}
    func configure(with model: DetailMovieModel) {}
}

