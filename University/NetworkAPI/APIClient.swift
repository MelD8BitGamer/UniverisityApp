//
//  APIClient.swift
//  University
//
//  Created by Melinda Diaz on 1/2/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import Foundation
import UIKit


struct APIClient{
    //TODO: refactor into using a completion handler to get back universities
    static func getSchools(for urlString: String,
                           completion: @escaping (Result<[Universities], AppError>) -> ()) { //it takes in a valid url     static func getPodcasts(for searchQuery: String,
        guard let url = URL(string: urlString) else { completion(.failure(.badURL(urlString)))
            return
        }
        
           let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.postDataTask(request: urlRequest) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {//any function that uses an error you must try
                    let searchResults = try JSONDecoder().decode([Universities].self, from: data)
                    
                    // 2. capture the array of results in the completion handler
                    completion(.success(searchResults))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
