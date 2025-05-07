//
//  EndpointConfigurable.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

import Foundation

public protocol EndpointConfigurable {
    var baseURL: URL? { get }
    var apiVersion: String { get }
    var apiToken: String { get }
}
