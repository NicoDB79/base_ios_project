import SwiftData
import Domain

@ModelActor
public actor OrderRepositoryImpl: OrderRepository {
    public static func makeModelContainer() throws -> ModelContainer {
        try ModelContainer(for: OrderEntity.self)
    }

    public func loadOrders() async throws -> [Order] {
        let descriptor = FetchDescriptor<OrderEntity>()
        return try modelContext.fetch(descriptor).map { Order(code: $0.code) }
    }

    public func save(_ order: Order) async throws {
        modelContext.insert(OrderEntity(code: order.code))
        try modelContext.save()
    }
}
