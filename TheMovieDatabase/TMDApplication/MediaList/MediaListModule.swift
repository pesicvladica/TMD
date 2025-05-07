//
//  MediaListModule.swift
//  TMDApplication
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import SwiftUI
import TheMovieDatabase

enum MediaListModule {
    @MainActor static func makeModule<Router: MediaListRouterProtocol>(router: Router) -> some View {
        guard let url = Bundle.main.infoDictionary?["API_URL"] as? String,
              let version = Bundle.main.infoDictionary?["API_VERSION"] as? String,
              let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            preconditionFailure("Please provide API in order to continue")
        }
              
        debugPrint(url)
        debugPrint(version)
        debugPrint(key)
        
        let config = EndpointConfiguration(url: URL(string: url),
                                           version: version,
                                           token: key)
        let request = RequestBuilder(configuration: config)
        
        let configWithCache = URLSessionConfiguration.default
        configWithCache.requestCachePolicy = .returnCacheDataElseLoad
        configWithCache.urlCache = URLCache(memoryCapacity: 20_000_000,
                                            diskCapacity: 100_000_000,
                                            diskPath: "moviedb_cache")
        let sessionWithCache = URLSession(configuration: configWithCache)
        let fetcher = Fetcher(request: request, session: sessionWithCache)
        
        let networking = MovieDB(fetchable: fetcher)
        
        let interactor = MediaListInteractor(networking: networking)
        let presenter = MediaListPresenter(interactor: interactor)
        
        return MediaListView(presenter: presenter, router: router)
    }
}
