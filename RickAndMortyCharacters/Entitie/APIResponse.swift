//
//  APIResponse.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 23/03/21.
//

import Foundation

struct APIResponse: Codable {
    
    var info: Info?
    var results: [Character]?
}
