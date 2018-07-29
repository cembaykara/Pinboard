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
    var likes: Int?
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

enum PhotoSize {
    case small
    case medium
    case large
}

extension Object {
    
    func userName() -> String {
        guard let userName = self.user?.username else {return ""}
        return userName
    }
    
    func userLikes() -> String {
        guard let userLikes = self.likes else {return ""}
        return "\(userLikes)"
    }
    
    func photo(_ withSize: PhotoSize) -> String?{
        switch withSize {
        case .small:
            return user?.profileImage?.small
        case .medium:
            return user?.profileImage?.medium
        case .large:
            return user?.profileImage?.large
        }
    }
    
}
