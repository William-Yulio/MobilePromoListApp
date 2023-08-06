//
//  NetworkService.swift
//  Mobile Promo
//
//  Created by William Yulio on 04/08/23.
//

import Foundation
import UIKit

enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}

struct networkManager {
    
    public static let shared = networkManager()
    public init () {}
    
    public func fetchPromosData(completion: @escaping(Result<[PromoElement], APIError>) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://content.digi46.id/promos")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        let headers = [
          "accept": "application/json"
        ]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
            if error != nil {
                print("dataTask error: \(error!.localizedDescription)")
                completion(.failure(.failed(error: error!)))
                
            } else if let data = data {
                // Success request
                do {
                    let promo = try JSONDecoder().decode([PromoElement].self, from: data)
                    print("success")
                    completion(.success(promo))
                } catch {
                    // Send error when decoding
                    print("decoding error")
                    print(error)
                    completion(.failure(.errorDecode))
                }
            } else {
                print("unknown dataTask error")
                completion(.failure(.unknownError))
            }
        }
        dataTask.resume()
    }
}
