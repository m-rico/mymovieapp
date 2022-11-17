//
//  APICaller.swift
//  mymovie
//
//  Created by user on 12/11/22.
//

import Foundation


struct Constants {
    static let apiKey = "5ec0346f7760ab4e03359a781b71c2ee"
    static let baseURL = "https://api.themoviedb.org/3"
    static let youtubeBaseURL = "https://www.youtube.com/watch?v="
    //let urlString = "https://api.themoviedb.org/3/movie/361743/reviews?api_key=5ec0346f7760ab4e03359a781b71c2ee&language=en-US&page=1"
    
    
}

class APICaller {
    static let shared = APICaller()
    
    func getGenreMovie(id genreId: Int, complition: @escaping (Result<[MovieTwo], Error>)->Void) {
        let urlString = Constants.baseURL + "/discover/movie?api_key=" + Constants.apiKey + "&with_genres=\(genreId)"
        var tempMovie = MovieTwo()
        var movies: [MovieTwo] = [MovieTwo]()
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                guard let safeData = data else {
                    return
                }
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(Movie.self, from: safeData)
                    
                    for result in decodedData.results {
                        tempMovie.title = result.title
                        tempMovie.id = result.id
                        tempMovie.overview = result.overview
                        tempMovie.poster_path = result.poster_path
                        
                        if movies.contains(where: { $0.id == tempMovie.id}) {
                            //nothing
                        } else {
                            if tempMovie.title != "" {
                                
                                movies.append(tempMovie)
                                
                            }
                        }
                    }
                    complition(.success(movies))
                } catch {
                    complition(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getMovieToo(with query: Int, complition: @escaping (Result<Items, Error>)->Void) {
        let url = "\(Constants.baseURL)/movie/\(query)?api_key=\(Constants.apiKey)&append_to_response=videos"
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                guard let safeData = data else {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(YoutubeData.self, from: safeData)
                    complition(.success(decodedData.videos.results[0]))
                } catch {
                    complition(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getReview(queryId: Int, complition: @escaping (Result<[ReviewModel], Error>)->Void) {
        
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
                    let decodedData = try decoder.decode(Review.self, from: safeData)
                    //                    let resultReview = decodedData.results[0]
                    var tempReview = ReviewModel()
                    //                    tempReview.id = resultReview.id
                    //                    tempReview.author = resultReview.author
                    //                    tempReview.content = resultReview.content
                    //                    tempReview.created_at = resultReview.created_at
                    var reviews = [ReviewModel]()
                    
                    for result in decodedData.results {
                        tempReview.author = result.author
                        tempReview.id = result.id
                        tempReview.content = result.content
                        tempReview.created_at = result.created_at
                        
                        if reviews.contains(where: { $0.id == tempReview.id}) {
                            //nothing
                        } else {
                            if tempReview.author != "" {
                                
                                reviews.append(tempReview)
                            }
                        }
                    }
                    
                    
                    complition(.success(reviews))
                } catch {
                    print("portugal err")
                    complition(.failure(error))
                }
            }
            //step 4 : Start The Task
            task.resume()
        }
        
    }
    
    
    
    var isPaginating = false
    func getMovieMore(page: Int, paginating: Bool = false, preMov: [MovieTwo], complition: @escaping (Result<[MovieTwo], Error>)->Void) {
        if paginating {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (paginating ? 3 : 2 )) {
            let urlString = "\(Constants.baseURL)/discover/movie?api_key=\(Constants.apiKey)&page=\(page)"
//            let urlString = "\(Constants.baseURL)/movie/\(page)?api_key=\(Constants.apiKey)&append_to_response=videos"
            
            print("denmark \(urlString)")
            if let url = URL(string: urlString) {
                //step 2 : Create a URLSession
                let session = URLSession(configuration: .default)
                //step 3 : Give URLSession a task
                let task = session.dataTask(with: url) { data, response, error in
                    if error != nil {
                        //fetchError.failed
                        return
                    }
                    guard let safeData = data else {
                        return
                    }
                    if let dataString = String(data: safeData, encoding: .utf8) {
//                        print(dataString)
                        print("sweden 1 \(dataString)")
                    }

                    let decoder = JSONDecoder()
                    
                    do {
                        let decodedData = try decoder.decode(Movie.self, from: safeData)
                        
                        var tempMovie = MovieTwo()
                        var movies = [MovieTwo]()
                        print("bosnia 1 \(decodedData.page)")
//                        movies = preMov
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
                        print("denmark \(movies.count)")
                        complition(.success(movies))
//                        complition(.success(paginating ? movies))
                        if paginating {
                            self.isPaginating = false
                        }
                        
                    } catch {
                        
                        complition(.failure(error))
                    }
                }
                
                //step 4 : Start The Task
                task.resume()
            }
            
        }
    }
}
