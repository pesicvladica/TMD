//
//  RequestBuildable.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//
import Foundation

public protocol RequestBuildable {
    func buildFor(endpoint: EndpointConvertible) throws -> URLRequest
}

