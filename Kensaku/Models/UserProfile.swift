//
//  UserProfile.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

struct UserProfile: Identifiable, Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case name, id, login, followers, following
    }
}
