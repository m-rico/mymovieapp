//
//  Router.swift
//  mymovie
//
//  Created by user on 09/11/22.
//

//Object
// EntryPoint

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get set }
    static func start() -> AnyRouter
}

class MainRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = MainRouter()
        
        //Assign VIP
        
        var view: AnyView = MainViewController()
        var presenter: AnyPresenter = MainPresenter()
        var interactor: AnyInteractor = MainInteactor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
