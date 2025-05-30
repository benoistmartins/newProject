import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: viewModel.avatarURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(radius: 5)
            
            Text(viewModel.fullName).font(.title)
            Text(viewModel.email).foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Profil")
    }
}
