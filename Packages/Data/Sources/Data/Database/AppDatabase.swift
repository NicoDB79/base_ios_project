import SwiftData

public enum AppDatabase {
    public static func makeModelContainer() throws -> ModelContainer {
        let schema = Schema([
            OrderEntity.self,
        ])
        return try ModelContainer(for: schema)
    }
}
