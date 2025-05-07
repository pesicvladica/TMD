//
//  Media.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

protocol MediaResponseProtocol: Decodable {
    associatedtype Model
    
    var page: Int { get }
    var results: [Model] { get }
}

protocol MediaConvertible {
    func toMedia() -> Media
}

public struct Media: Equatable, Identifiable {
    public var id: Int {
        mediaId
    }
    
    public let mediaType: MediaType
    
    public let mediaId: Int
    
    public let poster: String
    public let title: String
    public let rating: Double

    public let subtitle1: String?
    public let subtitle2: String?
}

extension Media {
    init(from model: Movie) {
        self.mediaType = .movie
        self.mediaId = model.id
        self.title = model.title
        self.rating = model.vote_average
        self.poster = model.poster_path
        self.subtitle1 = nil
        self.subtitle2 = nil
    }
    
    init(from model: MovieDetails) {
        self.mediaType = .movie
        self.mediaId = model.id
        self.title = model.title
        self.rating = model.vote_average
        self.poster = model.poster_path
        self.subtitle1 = String(model.budget)
        self.subtitle2 = String(model.revenue)
    }
    
    init(from model: Show) {
        self.mediaType = .tv
        self.mediaId = model.id
        self.title = model.name
        self.rating = model.vote_average
        self.poster = model.poster_path
        self.subtitle1 = nil
        self.subtitle2 = nil
    }
    
    init(from model: ShowDetails) {
        self.mediaType = .tv
        self.mediaId = model.id
        self.title = model.name
        self.rating = model.vote_average
        self.poster = model.poster_path
        self.subtitle1 = model.last_air_date
        self.subtitle2 = model.last_episode_to_air_name
    }
}
