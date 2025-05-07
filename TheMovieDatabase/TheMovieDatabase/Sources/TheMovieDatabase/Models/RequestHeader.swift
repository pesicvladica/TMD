//
//  RequestHeader.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

enum RequestHeader {
    case accept
    case authorization(String)
    
    var key: String {
        switch self {
            case .accept: return "Accept"
            case .authorization: return "Authorization"
        }
    }
    
    var value: String {
        switch self {
            case .accept: return "application/json"
            case .authorization(let token): return "Bearer \(token)"
        }
    }
}
