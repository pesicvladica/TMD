//
//  RequestBuilder.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation

public final class RequestBuilder: RequestBuildable {
    
    private let configuration: EndpointConfigurable
    
    public init(configuration: EndpointConfigurable) {
        self.configuration = configuration
    }
    
    public func buildFor(endpoint: EndpointConvertible) throws -> URLRequest {
        guard let url = endpoint.makeURLwith(configuration: configuration) else {
            throw NetworkError.urlError("Url could not be built")
        }
        
        var urlRequest = URLRequest(url: url)
        
        let authorizationToken = RequestHeader.authorization(configuration.apiToken)
        urlRequest.setValue(authorizationToken.value,
                            forHTTPHeaderField: authorizationToken.key)
        urlRequest.setValue(RequestHeader.accept.value,
                            forHTTPHeaderField: RequestHeader.accept.key)
        
        return urlRequest
    }
}
