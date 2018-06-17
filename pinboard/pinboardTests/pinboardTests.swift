//
//  pinboardTests.swift
//  pinboardTests
//
//  Created by Baris Cem Baykara on /146/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import XCTest
import GenericFetcher

class pinboardTests: XCTestCase {
    
    func testExample() {
        let fetcher = Fetcher()
        var error = false
        fetcher.fetch(with: .json, urlStr: "http://pastebin.com/raw/wgkJgazE") { (data: [Object], _, err) in
            if err != nil {
                error = true
            }
        }
        XCTAssert(!error)
    }
    
}
