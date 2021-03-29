//
//  RequestAPI.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 22/03/21.
//

import UIKit

class RequestAPI {
    
    let session = URLSession.shared
    let request = NSMutableURLRequest()
    
    func request<T:Decodable>(method: RequestType, endpoint: String, parameters: Dictionary<String, Any>, responseType: T.Type, completion: @escaping (_ response: Any?, _ code: Int) -> Void) {
        
        let baseURL = "https://rickandmortyapi.com/api/"
        
        var serverURL:String = baseURL + endpoint
        
        switch method {
        case .get:
            serverURL += parameters.buildQueryString()
            request.httpMethod = "GET"
            break
        }
        
        request.url = URL(string: serverURL)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil {
                print(error.debugDescription)
                completion(nil, 401)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(responseType, from: data!)
                completion(json, 200)
            } catch {
                print("Error during JSON serialization: \(error)")
                completion(nil, 401)
            }
            
        })
        task.resume()
    }
}
