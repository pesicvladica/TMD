//
//  MediaListInteractor.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import Combine
import TheMovieDatabase

protocol MediaListInteractorProtocol {
    func fetchGenres(for type: MediaType) -> AnyPublisher<[Genre], Error>
    func fetchMedia(for type: MediaType, genre: Genre, page: Int) -> AnyPublisher<[Media], Error>
    func fetchDetails(for type: MediaType, mediaId: Int) -> AnyPublisher<Media, Error>
}

final class MediaListInteractor: MediaListInteractorProtocol {
    private let networking: MovieDBRepository

    init(networking: MovieDBRepository) {
        self.networking = networking
    }

    func fetchGenres(for type: MediaType) -> AnyPublisher<[Genre], Error> {
        networking
            .fetchGenres(type: type)
            .receive(on: DispatchQueue.main)
            .map { $0.genres }
            .eraseToAnyPublisher()
    }

    func fetchMedia(for type: MediaType, genre: Genre, page: Int) -> AnyPublisher<[Media], Error> {
        networking
            .fetchList(type: type, genre: genre, page: page)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchDetails(for type: MediaType, mediaId: Int) -> AnyPublisher<Media, Error> {
        networking.fetchDetails(type: type, mediaId: mediaId)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

