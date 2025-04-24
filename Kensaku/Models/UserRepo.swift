//
//  UserRepo.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

struct UserRepo: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let htmlUrl: String
    let fork: Bool
    
    enum CodingKeys: String, CodingKey {
        case stargazersCount = "stargazers_count", htmlUrl = "html_url"
        case id, name, description, language, fork
    }
}
