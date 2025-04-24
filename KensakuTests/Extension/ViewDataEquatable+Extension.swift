//
//  ViewDataEquatable+Extension.swift
//  KensakuTests
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation
@testable import Kensaku


extension UserProfileViewData: Swift.Equatable {
    public static func == (lhs: UserProfileViewData, rhs: UserProfileViewData) -> Bool {
        return lhs.id == rhs.id &&
            lhs.atUsername == rhs.atUsername &&
            lhs.displayName == rhs.displayName &&
            lhs.avatarUrl == rhs.avatarUrl &&
            lhs.followers == rhs.followers &&
            lhs.following == rhs.following &&
            lhs.repositories == rhs.repositories
    }
}

extension UserRepoViewData: Swift.Equatable {
    public static func == (lhs: UserRepoViewData, rhs: UserRepoViewData) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.stars == rhs.stars &&
            lhs.language == rhs.language &&
            lhs.url == rhs.url &&
            lhs.fork == rhs.fork
    }
}

extension UserViewData: Swift.Equatable {
    public static func == (lhs: UserViewData, rhs: UserViewData) -> Bool {
        return lhs.username == rhs.username &&
        lhs.id == rhs.id &&
        lhs.avatarUrl == rhs.avatarUrl
    }
    
    
}
