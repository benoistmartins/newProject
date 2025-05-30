import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Chargement...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("❌ Erreur")
                            .font(.headline)
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Réessayer") {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(viewModel: UserDetailViewModel(user: user))) {
                            HStack {
                                AsyncImage(url: URL(string: user.avatar)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } else if phase.error != nil {
                                        Color.red
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(user.fullName)
                                        .font(.headline)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Utilisateurs")
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}
