//
//  DetailMovieRouter.swift
//  mymovie
//
//  Created by user on 15/11/22.
//

import Foundation


class DetailMovieRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = DetailMovieRouter()
        
        var view: AnyView = DetailMovieView()
        var presenter: AnyPresenter = DetailMoviePresenter()
        var interactor: AnyInteractor = DetailMovieInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
