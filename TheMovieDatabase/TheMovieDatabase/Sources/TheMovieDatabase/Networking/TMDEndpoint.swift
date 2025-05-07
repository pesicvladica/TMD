//
//  TMDEndpoint.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation

enum TMDEndpoint: EndpointConvertible {
    case genres(type: MediaType)
    case list(type: MediaType, parameters: [EndpointParameter])
    case details(type: MediaType, id: Int)
    
    private var path: String {
        switch self {
        case .genres(let type):
            return "/genre/\(type)/list"
        case .list(let type, _):
            return "/discover/\(type)"
        case .details(let type, let id):
            return "/\(type)/\(id)"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .list(_, let parameters):
            return parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        default:
            return nil
        }
    }
    
    func makeURLwith(configuration: EndpointConfigurable) -> URL? {
        guard let url = configuration.baseURL else { return nil }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.path = "/\(configuration.apiVersion)" + path
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
