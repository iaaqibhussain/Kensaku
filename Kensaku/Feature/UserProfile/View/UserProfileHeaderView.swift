//
//  UserProfileHeaderView.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct UserProfileHeaderView: View {
    let profileViewData: UserProfileViewData
    
    var body: some View {
        VStack(spacing: LayoutConstants.Spacing.four) {
            CachedAsyncImage(url: profileViewData.avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(
                width: LayoutConstants.Image.bigWidth,
                height: LayoutConstants.Image.bigHeight
            )
            .clipShape(Circle())
            
            VStack(spacing: LayoutConstants.Spacing.three) {
                Text(profileViewData.displayName)
                    .font(.title2)
                    .bold()
                
                Text(profileViewData.atUsername)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: LayoutConstants.Spacing.five) {
                    VStack {
                        Text(profileViewData.followerTitle)
                            .font(.headline)
                        Text(profileViewData.followers)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack {
                        Text(profileViewData.followingTitle)
                            .font(.headline)
                        Text(profileViewData.following)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}
