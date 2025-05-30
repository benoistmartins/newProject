import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiService = APIService()
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await apiService.fetchUsers()
        } catch {
            errorMessage = "Échec du chargement : \(error.localizedDescription)"
        }
        isLoading = false
    }
}
