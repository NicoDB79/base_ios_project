import SwiftData
import Domain

@ModelActor
public actor OrderRepositoryImpl: OrderRepository {
    public func loadOrders() async throws -> [Order] {
        let descriptor = FetchDescriptor<OrderEntity>()
        return try modelContext.fetch(descriptor).map { Order(code: $0.code, orderDescription: $0.orderDescription, customer: $0.customer) }
    }

    public func save(_ order: Order) async throws {
        modelContext.insert(OrderEntity(code: order.code))
        try modelContext.save()
    }

    public func seedIfNeeded() async throws {
        let count = try modelContext.fetchCount(FetchDescriptor<OrderEntity>())
        guard count == 0 else { return }

        let seedOrders = [
            OrderEntity(code: "ORD-001", orderDescription: "Office supplies", customer: "Acme Corp"),
            OrderEntity(code: "ORD-002", orderDescription: "Electronic components", customer: "TechStart Inc"),
            OrderEntity(code: "ORD-003", orderDescription: "Furniture delivery", customer: "HomeBase Ltd"),
            OrderEntity(code: "ORD-004", orderDescription: "Industrial tools", customer: "BuildRight Co"),
            OrderEntity(code: "ORD-005", orderDescription: "Medical equipment", customer: "HealthPlus Srl"),
        ]
        seedOrders.forEach { modelContext.insert($0) }
        try modelContext.save()
    }
}
