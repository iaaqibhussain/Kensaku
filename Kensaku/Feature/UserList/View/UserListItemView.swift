//
//  UserListItemView.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct UserListItemView: View {
    let userViewData: UserViewData
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: userViewData.avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(
                width: LayoutConstants.Image.smallwidth,
                height: LayoutConstants.Image.smallheight
            )
            .clipShape(Circle())
            
            Text(userViewData.username)
                .font(.headline)
        }
        .padding(.vertical, LayoutConstants.Spacing.two)
    }
}
