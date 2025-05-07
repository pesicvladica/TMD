//
//  Movie.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

struct Movie: Decodable {
    let id: Int
    let title: String
    let vote_average: Double
    let poster_path: String
}

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let vote_average: Double
    let poster_path: String
    let budget: Int
    let revenue: Int
}

extension Movie: MediaConvertible {
    func toMedia() -> Media { Media(from: self) }
}

extension MovieDetails: MediaConvertible {
    func toMedia() -> Media { Media(from: self) }
}

struct MovieResponse: MediaResponseProtocol {
    typealias Model = Movie
    
    let page: Int
    let results: [Movie]
}
