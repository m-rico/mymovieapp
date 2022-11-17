//
//  DetailMovieView.swift
//  mymovie
//
//  Created by user on 15/11/22.
//

import Foundation
import UIKit
import WebKit

class DetailMovieView: UIViewController, AnyView {
    var presenter: AnyPresenter?
    
    private var headerView: ReviewHeaderUIView?
    var movieData = DetailMovieModel()
    var reviewData = [ReviewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        headerView = ReviewHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.tableHeaderView = headerView
//        navigationController?.navigationBar.tintColor = .label
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = view.bounds
    }
    
    func configure(with model: DetailMovieModel) {
        self.tableView.isHidden = false
        DispatchQueue.main.async {
            self.movieData = model
            self.headerView?.configure(with: model)
        }
        APICaller.shared.getReview(queryId: model.id ?? 0) { result in
            switch result {
            case .success(let review):
                print("sweden \(review)")
                self.reviewData = review
            case .failure(let error):
                print("sweden \(error)")
            }
        }
        
    }
}

extension DetailMovieView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.userNames.count
        print("netherland \(self.reviewData.count)")
        return self.reviewData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: self.reviewData[indexPath.row].author ?? "", date: self.reviewData[indexPath.row].created_at ?? "", review: self.reviewData[indexPath.row].content ?? "")
//        cell.configure(name: self.userNames[indexPath.row], date: self.dateReview[indexPath.row], review: self.textReview[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Review From User :"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "Poppins-Bold", size: 20)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 400, height: header.bounds.height)
        header.textLabel?.textColor = .label
    }
}

