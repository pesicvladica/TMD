//
//  Fetchable.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation
import Combine

public protocol Fetchable {
    var decoder: JSONDecoder { get }
    
    func fetchRaw(endpoint: EndpointConvertible) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}
