//
//  UserProfileViewData.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

struct UserProfileViewData: Identifiable {
    let id: Int
    let atUsername: String
    let displayName: String
    let avatarUrl: URL?
    let followingTitle: String = "Following"
    let followerTitle: String = "Followers"
    let followers: String
    let following: String
    let repositories: [UserRepoViewData]
    let doneTitle: String = "Done"
}
