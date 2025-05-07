//
//  MediaListRouter.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import TheMovieDatabase

protocol MediaListRouterProtocol {
    func routeToDetail(of media: Media)
}

final class MediaListRouter: MediaListRouterProtocol {
    func routeToDetail(of media: Media) {
        debugPrint("Navigate to details of: \(media.title)")
    }
}
