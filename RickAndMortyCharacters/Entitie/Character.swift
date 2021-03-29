//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 22/03/21.
//

import Foundation

struct Character: Codable {
    
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var image: String?
    var episode: [String]?
    var created: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case image
        case episode
        case created
    }
}
