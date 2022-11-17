//
//  Interactor.swift
//  mymovie
//
//  Created by user on 09/11/22.
//

import Foundation

//object
//protocol
// ref to presenter

//to get image: https://image.tmdb.org/t/p/w500/wRKHUqYGrp3PO91mZVQ18xlwYzW.jpg

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getMovie()
    func getGenreType()
    func getReview(queryId: Int)
}

class MainInteactor: AnyInteractor {
    var presenter: AnyPresenter?
    
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=5ec0346f7760ab4e03359a781b71c2ee&page=1"
    
    func getMovie() {
        print("wakandaaa")
        if let url = URL(string: urlString) {
            
            //step 2 : Create a URLSession
            let session = URLSession(configuration: .default)

            //step 3 : Give URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
//                    fetchError.failed
                    return
                }
                guard let safeData = data else {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    
                    let decodedData = try decoder.decode(Movie.self, from: safeData)
                    var tempMovie = MovieTwo()
                    var movies = [MovieTwo]()

                    for result in decodedData.results {
                        tempMovie.title = result.title
                        tempMovie.id = result.id
                        tempMovie.overview = result.overview
                        tempMovie.poster_path = result.poster_path
                        tempMovie.release_date = result.release_date
                        tempMovie.vote_average = result.vote_average
                        if movies.contains(where: { $0.id == tempMovie.id}) {
                            //nothing
                        } else {
                            if tempMovie.title != "" {
                                movies.append(tempMovie)
                            }
                        }
                    }
                    
//                    let movie = MovieModel(title: result)
                    
                    
//                    self.presenter?.interactorDidFetchMovie(with: .success(movie))
                    self.presenter?.interactorDidFetchMovie(with: .success(movies))
                } catch {
                    print("portugal err")
                    self.presenter?.interactorDidFetchMovie(with: .failure(error))
                }
            }
            
            //step 4 : Start The Task
            task.resume()
        }
    }
    
}
extension AnyInteractor{
    func getMovie() {}
    func getGenreType() {}
    func getReview(queryId: Int) {}
}
