import Foundation

class UserDetailViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var fullName: String { user.fullName }
    var email: String { user.email }
    var avatarURL: URL? { URL(string: user.avatar) }
}
