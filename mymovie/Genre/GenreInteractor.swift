//
//  GenreInteractor.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation

enum APIError: Error {
    case failTogetData
}

class GenreInteractor: AnyInteractor {
    
//    static let shared = GenreInteractor()
    var presenter: AnyPresenter?
    
    func getGenreType() {
        let urlString = Constants.baseURL + "/genre/movie/list?api_key=" + Constants.apiKey
        if let url = URL(string: urlString) {
            
            //step 2 : Create a URLSession
            let session = URLSession(configuration: .default)
            
            //step 3 : Give URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                guard let safeData = data else {
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(GenreData.self, from: safeData)
                    var genres = [GenreModel]()
                    var temGenre = GenreModel()

                    
                    for result in decodedData.genres {
                        temGenre.id = result.id
                        temGenre.name = result.name
                        if genres.contains(where: { $0.id == result.id}) {
                            //nothing
                        } else {
                            if temGenre.name != "" {
                                genres.append(temGenre)
                                
                            }
                        }
                    }
                    self.presenter?.interactorDidFetchGenre(with: .success(genres))
                } catch {
                    self.presenter?.interactorDidFetchGenre(with: .failure(error))
                }
            }
            task.resume()
        }
    }    
    
}
