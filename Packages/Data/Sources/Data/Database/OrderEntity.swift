import SwiftData

@Model
final class OrderEntity {
    var code: String

    init(code: String) {
        self.code = code
    }
}
