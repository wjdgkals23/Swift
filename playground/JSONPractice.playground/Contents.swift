import UIKit

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}

let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
    let data = try encoder.encode(pear)
    print(String(data: data, encoding: String.Encoding.utf8)!)
} catch {
    print(error)
}

let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

do {
    let product = try decoder.decode(GroceryProduct.self, from: json)
    print(product.name)
} catch {
    print(error)
}
