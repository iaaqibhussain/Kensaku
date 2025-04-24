//
//  UserRepoViewData.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

struct UserRepoViewData: Identifiable {
    let id: Int
    let name: String
    let description: String
    let stars: String
    let language: String
    let url: URL?
    let fork: Bool
}
