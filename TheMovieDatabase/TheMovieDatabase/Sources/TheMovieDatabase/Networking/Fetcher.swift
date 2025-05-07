//
//  Fetcher.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import Combine

public final class Fetcher: Fetchable {
    
    private let request: RequestBuildable
    private let session: URLSession
    public let decoder: JSONDecoder
    
    public init(request: RequestBuildable,
                session: URLSession = .shared,
                decoder: JSONDecoder = JSONDecoder()) {
        self.request = request
        self.session = session
        self.decoder = decoder
    }
    
    public func fetchRaw(endpoint: any EndpointConvertible) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        do {
            let request = try request.buildFor(endpoint: endpoint)
            return session.dataTaskPublisher(for: request)
                .mapError { $0 as Error }
                .tryMap { data, response in
                            guard let httpResponse = response as? HTTPURLResponse,
                                  (200...299).contains(httpResponse.statusCode) else {
                                throw URLError(.badServerResponse)
                            }
                            return (data: data, response: response)
                        }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
