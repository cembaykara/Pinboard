//
//  FetcherError.swift
//  GenericFetcher
//
//  Created by Baris Cem Baykara on /297/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import Foundation

enum FetcherError{
    case requestFailed
    case jsonConversionFailed
    case invalidData
    case responseUnsuccessfull
    
    var description: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .jsonConversionFailed:
            return "JSON Conversion Failed"
        case .invalidData:
            return "Received Invalid Data"
        case .responseUnsuccessfull:
            return "Response was unsuccesful"
        }
    }
}
