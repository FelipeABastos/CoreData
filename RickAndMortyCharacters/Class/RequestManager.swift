//
//  RequestManager.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 22/03/21.
//

import Foundation

class RequestManager {
    
    func loadData(page: Int, completion: @escaping (_ objects: Array<Character>, _ pageLimit: Int) -> Void) {
        
        let endpoind = "character/?page=\(page)"
        
        RequestAPI().request(method: .get, endpoint: endpoind, parameters: [:], responseType: APIResponse.self) { (object, code) in
            if code == 200 {
                if let object = object as? APIResponse {
                    completion(self.databaseSync(object.results ?? []), object.info?.pages ?? 0)
                }
            }
        }
    }
    
    private func databaseSync(_ characters: [Character]) -> [Character] {
        
        let database = DatabaseCharacter()
        
        var intersection: [Character] = []
        
        for character in characters {
            intersection.append(character)
        }
        
        for item in intersection {
            if database.create(character: item) {
                print("Character created: \(item.name ?? "")")
            }else{
                print("Error on create character: \(item.name ?? "")")
            }
        }
        
        return database.getAll()
    }
}
