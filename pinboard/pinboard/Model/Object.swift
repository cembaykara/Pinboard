//
//  Data.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /126/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import Foundation

// Model objects for the given example URL
struct Object: Decodable {
    var user: User?
}

struct User: Decodable {
    var username : String?
    var profileImage : Photos?
}

struct Photos: Decodable {
    var small: String?
    var medium: String?
    var large: String?
}
