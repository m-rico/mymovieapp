//
//  GenrePresenter.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation

class GenrePresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getGenreType()
            interactor?.getMovie()
            
        }
    }
    var view: AnyView?
    
    func interactorDidFetchMovie(with result: Result<[MovieTwo], Error>) {

        switch result {
        case .success(let movies):
            print("france true")
            view?.update(with: movies)
        case .failure:
            print("france err")
            view?.update(with: "something wrong")
        }
    }
    
    func interactorDidFetchGenre(with result: Result<[GenreModel], Error>) {
        switch result {
        case .success(let genres):
//            print("usa \(genres.id)")
            view?.update(with: genres)
        case .failure:
            print("usa err")
            view?.update(with: "something wrong")
        }
    }
}
