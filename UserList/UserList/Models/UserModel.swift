import Foundation

struct UserResponse: Codable {
    let data: [User]
}

struct User: Identifiable, Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
    
    var fullName: String {
        "\(first_name) \(last_name)"
    }
}
