import SwiftData

@Model
final class OrderEntity {
    var code: String
    var orderDescription: String
    var customer: String

    init(code: String, orderDescription: String = "", customer: String = "") {
        self.code = code
        self.orderDescription = orderDescription
        self.customer = customer
    }
}
