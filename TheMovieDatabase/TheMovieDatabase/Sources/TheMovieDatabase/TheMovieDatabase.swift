// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine

public protocol MovieDBRepository {
    func fetchGenres(type: MediaType) -> AnyPublisher<Genres, Error>
    func fetchList(type: MediaType, genre: Genre, page: Int) -> AnyPublisher<[Media], Error>
    func fetchDetails(type: MediaType, mediaId: Int) -> AnyPublisher<Media, Error>
}

public final class MovieDB: MovieDBRepository {
    
    private let fetchable: Fetchable
    
    public init(fetchable: Fetchable) {
        self.fetchable = fetchable
    }
    
    // MARK: Public
    
    public func fetchGenres(type: MediaType) -> AnyPublisher<Genres, Error> {
        let api = TMDEndpoint.genres(type: type)
        return fetchable.fetchRaw(endpoint: api)
            .map(\.data)
            .decode(type: Genres.self, decoder: fetchable.decoder)
            .eraseToAnyPublisher()
    }
    
    public func fetchList(type: MediaType, genre: Genre, page: Int = 1) -> AnyPublisher<[Media], Error> {
        let parameters = [
            EndpointParameter(key: "with_genres", value: String(genre.id)),
            EndpointParameter(key: "page", value: String(page)),
        ]
        let api = TMDEndpoint.list(type: type, parameters: parameters)
        
        switch type {
        case .movie:
            return fetchable.fetchRaw(endpoint: api)
                             .map(\.data)
                             .decode(type: MovieResponse.self, decoder: fetchable.decoder)
                             .map { $0.results.map { $0.toMedia() } }
                             .eraseToAnyPublisher()
        case .tv:
            return fetchable.fetchRaw(endpoint: api)
                             .map(\.data)
                             .decode(type: ShowResponse.self, decoder: fetchable.decoder)
                             .map { $0.results.map { $0.toMedia() } }
                             .eraseToAnyPublisher()
        }
    }
    
    public func fetchDetails(type: MediaType, mediaId: Int) -> AnyPublisher<Media, Error> {
        let api = TMDEndpoint.details(type: type, id: mediaId)
        
        switch type {
        case .movie:
            return fetchable.fetchRaw(endpoint: api)
                             .map(\.data)
                             .decode(type: MovieDetails.self, decoder: fetchable.decoder)
                             .map { $0.toMedia() }
                             .eraseToAnyPublisher()
        case .tv:
            return fetchable.fetchRaw(endpoint: api)
                             .map(\.data)
                             .decode(type: ShowDetails.self, decoder: fetchable.decoder)
                             .map { $0.toMedia() }
                             .eraseToAnyPublisher()
        }
    }
}
