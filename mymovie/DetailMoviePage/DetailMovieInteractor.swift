//
//  DetailMovieInteractor.swift
//  mymovie
//
//  Created by user on 15/11/22.
//

import Foundation

class DetailMovieInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    func getReview(queryId: Int) {
        let urlString = "\(Constants.baseURL)/movie/\(queryId)/reviews?api_key=\(Constants.apiKey)"
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
