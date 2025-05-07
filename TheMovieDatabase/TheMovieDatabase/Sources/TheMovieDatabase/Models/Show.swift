//
//  Show.swift
//  TheMovieDatabase
//
//  Created by Vladica Pesic on 6.5.25..
//

struct Show: Decodable {
    let id: Int
    let name: String
    let vote_average: Double
    let poster_path: String
}

struct ShowDetails: Decodable {
    let id: Int
    let name: String
    let vote_average: Double
    let poster_path: String
    
    let last_air_date: String?
    let last_episode_to_air_name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, vote_average, poster_path, last_air_date, last_episode_to_air
    }
    
    enum LastEpisodeToAirKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        vote_average = try container.decode(Double.self, forKey: .vote_average)
        poster_path = try container.decode(String.self, forKey: .poster_path)
        
        last_air_date = try container.decode(String.self, forKey: .last_air_date)
        let lastEpisodeNameContainer = try container.nestedContainer(keyedBy: LastEpisodeToAirKeys.self, forKey: .last_episode_to_air)
        last_episode_to_air_name = try lastEpisodeNameContainer.decode(String.self, forKey: LastEpisodeToAirKeys.name)
    }
}

extension Show: MediaConvertible {
    func toMedia() -> Media { Media(from: self) }
}

extension ShowDetails: MediaConvertible {
    func toMedia() -> Media { Media(from: self) }
}

struct ShowResponse: MediaResponseProtocol {
    typealias Model = Show
    
    let page: Int
    let results: [Show]
}
