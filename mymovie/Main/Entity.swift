//
//  Entity.swift
//  mymovie
//
//  Created by user on 09/11/22.
//

import Foundation

struct Movie: Codable {
    var page: Int
    var results: [Results]
    var total_pages: Int
    var total_results: Int

}
struct Results: Codable {
    var id: Int
    var title: String
    var original_title: String
    var overview: String
    var popularity: Double
    let poster_path: String
    let release_date: String
    let vote_average: Double
    let vote_count: Int
}
struct MovieModel {
    var title: [String]
}

struct MovieTwo {
    var id: Int?
    var media_type: String?
    var title: String?
    var original_title: String?
    var poster_path: String?
    var overview: String?
    var vote_count: Int?
    var release_date: String?
    var vote_average: Double?
    var genre_ids: [Int]?
}

struct MainViewModel {
    let titleName: String
    let posterUrl: String
    let votedAverage: Double
    let releaseDate: String
}
