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
    public func fetch<T: Decodable>(with format: DecodableFormat, urlStr: String, completion: @escaping (T, URLResponse?, Error?) -> ()) {
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with: url!) { (receivedData, response, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to fetch:", err)
                    return
                }
                guard let receivedData = receivedData else { return }
                
                switch format {
                    
                case .json:
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try decoder.decode(T.self, from: receivedData)
                        completion(object, response, err)
                    } catch let jsonError {
                        print("Failed to decode json:", jsonError)
                    }
                    
                case .xml:
                    //XML Parsing here
                   return
                }
            }
        }.resume()
    }
}
