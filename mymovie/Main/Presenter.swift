//
//  Presenter.swift
//  mymovie
//
//  Created by user on 09/11/22.
//

//Object
//Protocol
// Ref to Interactor, router, view
import Foundation

enum fetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchMovie(with result: Result<[MovieTwo], Error>)
    func interactorDidFetchGenre(with result: Result<[GenreModel], Error>)
}

class MainPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getMovie()
        }
    }
    var view: AnyView?
    func interactorDidFetchMovie(with result: Result<[MovieTwo], Error>) {
        switch result {
        case .success(let movies):
            view?.update(with: movies)
        case .failure:
            print("france err")
            view?.update(with: "something wrong")
        }
    }
    
    
}
extension AnyPresenter {
    func interactorDidFetchMovie(with result: Result<[MovieTwo], Error>) {}
    func interactorDidFetchGenre(with result: Result<[GenreModel], Error>) {}
}
