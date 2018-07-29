//
//  Fetcher.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /146/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import Foundation

/// DecodableFormat type .json or .xml
public enum DecodableFormat {
    case json
    case xml
}

public class Fetcher {
    
    public init(){}
    
    /// Will parse DecodableFormat from a URL String
    ///
    /// - Parameters:
    ///   - format: .json or .xml
    public func fetch<T: Decodable>(with format: DecodableFormat, urlStr: String, completion: @escaping (T?,FetcherError?) -> ()) {
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with: url!) { (receivedData, response, err) in
            
            DispatchQueue.main.async {
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, .requestFailed)
                    return}
                
                if httpResponse.statusCode == 200 {
                    
                    guard let receivedData = receivedData else {
                        completion(nil, .invalidData)
                        return }
                    
                    switch format {
                    case .json:
                        
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let object = try decoder.decode(T.self, from: receivedData)
                            completion(object, nil)
                            
                        } catch {
                           completion(nil, .jsonConversionFailed)
                        }
                        
                    case .xml:
                        //XML Parsing here
                        return
                    }
                }else {
                    completion(nil, .responseUnsuccessfull)
                }
            }
        }.resume()
    }
}
