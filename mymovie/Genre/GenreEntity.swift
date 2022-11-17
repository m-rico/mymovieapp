//
//  GenreEntity.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation

struct GenreData: Codable {
    var genres: [Genre]
}

struct Genre: Codable {
    var id: Int
    var name: String
}

struct GenreModel {
    var id: Int?
    var name: String?
}

