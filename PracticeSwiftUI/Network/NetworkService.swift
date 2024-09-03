//
//  NetworkService.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import Foundation

final class NetworkService {
    enum NetworkError: Error {
        case defaultError
        case invalidResponse
        case invalidData
    }
    
    private init() { }
    static let shared = NetworkService()
    
    func fetchData(completion: @escaping ((Result<[Market], NetworkError>) -> Void)) {
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.defaultError))
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
 
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
