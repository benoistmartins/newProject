import Foundation

class APIService {
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Ajoute la clé API ici (remplace "reqres-free-v1" par ta clé)
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
        return userResponse.data
    }

}
