//
//  MediaListPresenter.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import Combine
import TheMovieDatabase

@MainActor
protocol MediaListPresenterProtocol: ObservableObject {
    
    var selectedMediaType: MediaType { get }
    var genres: [Genre] { get }
    var selectedGenre: Genre? { get }
    var mediaItems: [Media] { get }
    
    func select(mediaType: MediaType)
    func select(genre: Genre)
    func refresh()
    func shouldLoadMore(currentItem: Media) -> Bool
    func loadMore()
}

final class MediaListPresenter: MediaListPresenterProtocol {
        
    @Published private(set) var selectedMediaType: MediaType = .movie
    
    @Published private(set) var genres: [Genre] = []
    @Published private(set) var selectedGenre: Genre?
    
    @Published private(set) var mediaItems: [Media] = []
  
    @Published var isLoading = false
    @Published private var page = 1
    
    private let interactor: MediaListInteractorProtocol
    private var cancellables = Set<AnyCancellable>()

    init(interactor: MediaListInteractorProtocol) {
        self.interactor = interactor

        $selectedMediaType
            .flatMap { type in
                interactor.fetchGenres(for: type)
                    .handleEvents(receiveOutput: { [weak self] genres in
                            guard let firstGenre = genres.first else { return }
                            self?.selectedGenre = firstGenre
                    })
                    .replaceError(with: [])
            }
            .assign(to: \.genres, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest3($selectedMediaType, $selectedGenre.compactMap { $0 }, $page)
            .flatMap { type, genre, page in
                interactor.fetchMedia(for: type, genre: genre, page: page)
                    .flatMap { mediaList in
                        Publishers.MergeMany(
                            mediaList.compactMap { item in
                                item.isFullModel() ? nil : interactor.fetchDetails(for: type, mediaId: item.id)
                                    .replaceError(with: item)
                                    .eraseToAnyPublisher()
                            }
                        )
                        .collect()
                    }
                    .replaceError(with: [])
            }
            .sink { [weak self] newItems in
                 guard let self else { return }
                 
                 if self.page == 1 {
                     self.mediaItems = newItems
                 } else {
                     self.mediaItems.append(contentsOf: newItems)
                 }
             }
            .store(in: &cancellables)
    }

    // MARK: Inputs
    
    func select(mediaType: MediaType) {
        selectedGenre = nil
        refresh()
        selectedMediaType = mediaType
    }

    func select(genre: Genre) {
        selectedGenre = genre
        refresh()
    }
    
    func refresh() {
        page = 1
        mediaItems = []
    }
    
    func shouldLoadMore(currentItem: Media) -> Bool {
        return mediaItems.last == currentItem
    }
    
    func loadMore() {
        guard !isLoading else { return }
        page += 1
    }
}
