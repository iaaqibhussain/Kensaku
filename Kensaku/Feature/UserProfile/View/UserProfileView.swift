//
//  UserProfileView.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct UserProfileView: View {
    let username: String
    @StateObject private var viewModel = UserProfileViewModelImpl()
    @State private var selectedRepo: UserRepoViewData?
    @State private var isWebViewLoading = false
    
    var profileViewData: UserProfileViewData? {
        viewModel.profileViewData
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                profileHeaderView()
                repositoriesListView()
            }
            .task {
                await viewModel.fetchProfile(username)
            }
            .sheet(item: $selectedRepo) { repo in
                NavigationStack {
                    if let doneTitle = profileViewData?.doneTitle {
                        webView(repo, doneTitle)
                    }
                }
            }
            
            loadingView()
            errorView()
        }
    }
}

private extension UserProfileView {
    
    // MARK: - Profile Header View
    @ViewBuilder
    func profileHeaderView() -> some View {
        if let profileViewData = profileViewData {
            UserProfileHeaderView(profileViewData: profileViewData)
        }
    }
    
    // MARK: - Repo List View
    @ViewBuilder
    func repositoriesListView() -> some View {
        if let repositories = profileViewData?.repositories {
            LazyVStack(alignment: .leading, spacing: LayoutConstants.Spacing.four) {
                ForEach(repositories) { repo in
                    repositoryListItem(repo)
                }
            }
            .padding()
        }
    }
    
    // MARK: - Repo List Item
    func repositoryListItem(_ repo: UserRepoViewData) -> some View {
        Button {
            selectedRepo = repo
        } label: {
            UserProfileRepoListItem(repo: repo)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Web View
    @ViewBuilder
    func webView(
        _ repo: UserRepoViewData,
        _ buttonTitle: String
    ) -> some View {
        if let url = repo.url {
            ZStack {
                WebView(url: url, isLoading: $isWebViewLoading)
                    .navigationTitle(repo.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(buttonTitle) {
                                selectedRepo = nil
                            }
                        }
                    }
                
                if isWebViewLoading {
                    ProgressView()
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
    
    // MARK: - Loading View
    @ViewBuilder
    func loadingView() -> some View {
        if viewModel.isLoading {
            ProgressView()
        }
    }
    
    // MARK: - Error View
    @ViewBuilder
    func errorView() -> some View {
        if let errorMessage = viewModel.errorMessage {
            ErrorMessageView(message: errorMessage)
                .padding()
        }
    }
}
