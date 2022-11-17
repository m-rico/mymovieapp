//
//  GenreRouter.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation

class GenreRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = GenreRouter()
        
        var view: AnyView = GenreView()
        var presenter: AnyPresenter = GenrePresenter()
        var interactor: AnyInteractor = GenreInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
