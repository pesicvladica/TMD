//
//  Genres.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

public struct Genres: Decodable {
    public let genres: [Genre]
}

public struct Genre: Decodable, Equatable, Identifiable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
