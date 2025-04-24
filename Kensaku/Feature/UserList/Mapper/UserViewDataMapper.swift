//
//  UserViewDataMapper.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

protocol UserViewDataMapper {
    func map(_ users: [User]) -> [UserViewData]
}

final class UserViewDataMapperImpl: UserViewDataMapper {
    func map(_ users: [User]) -> [UserViewData] {
        users.map { user in
            UserViewData(
                id: user.id,
                username: user.login,
                avatarUrl: URL(string: user.avatarUrl)
            )
        }
    }
}
