//
//  EndpointConfiguration.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 7.5.25..
//

import Foundation

public final class EndpointConfiguration: EndpointConfigurable {
    public var baseURL: URL? { url }
    public var apiVersion: String { version }
    public var apiToken: String { token }
    
    private let url: URL?
    private let version: String
    private let token: String
    
    public init(url: URL?, version: String, token: String) {
        self.url = url
        self.version = version
        self.token = token
    }
}
