import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentPostgreSQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    //PostgreSQL configuration
    let config = PostgreSQLDatabaseConfig(hostname: "balarama.db.elephantsql.com", port: 5432, username: "afylspeh", database: "afylspeh", password: "Hrj5fa0WE8ZVyDhYmsQKBcE8MBvb8Ljr", transport: .cleartext)
    
    // Configure a SQLite database
    let postgre = PostgreSQLDatabase(config: config)
    //let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: postgre, as: .psql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Client.self, database: .psql)
    migrations.add(model: Company2.self, database: .psql)
    services.register(migrations)
}
