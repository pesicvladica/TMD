//
//  EndpointConvertible.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//
import Foundation

public protocol EndpointConvertible {
    func makeURLwith(configuration: EndpointConfigurable) -> URL?
}
