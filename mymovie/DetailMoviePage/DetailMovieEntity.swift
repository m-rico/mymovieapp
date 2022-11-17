//
//  DetailMovieEntity.swift
//  mymovie
//
//  Created by user on 15/11/22.
//

import Foundation


struct YoutubeData: Codable {
    var videos: VideoResults
}

struct VideoResults: Codable {
    var results: [Items]
}

struct Items: Codable {
    var name: String
    var key: String
}


struct DetailMovieModel {
    var id: Int?
    var title: String?
    var youtubeView: Items?
    var overview: String?
}

struct Review: Codable {
    var page: Int
    var results: [ResultsReview]
    var total_pages: Int
    var total_results: Int
}

struct ResultsReview: Codable {
    var author: String
    var content: String
    var created_at: String
    var id: String
}

struct ReviewModel {
    var id: String?
    var author: String?
    var content: String?
    var created_at: String?
}
/**
struct youtubeData: Codable {
    var kind: String
    var etag: String
    var nextPageToken: String
    var regionCode: String
    var pageInfo: InfoPage
    var items: [Items]
}

struct InfoPage: Codable {
    var totalResults: Int
    var resultsPerPage: Int
}

struct Items: Codable {
    var kind: String
    var etag: String
    var id: IdYt
}

struct IdYt: Codable {
    var kind: String
    var videoId: String
}

struct DetailMovieModel {
    var title: String?
    var youtubeView: Items?
    var overview: String?
}
 */
