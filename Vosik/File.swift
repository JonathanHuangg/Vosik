import MySQLKit
import NIO

class MySQLDatabaseConnector {
    private var pool: EventLoopGroupConnectionPool<MySQLConnectionSource>
    
    init(hostname: String, port: Int, username: String, password: String, database: String) {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        let configuration = MySQLConfiguration(
            hostname: hostname,
            port: port,
            username: username,
            password: password,
            database: database
        )
        self.pool = EventLoopGroupConnectionPool(
            source: MySQLConnectionSource(configuration: configuration),
            on: eventLoopGroup
        )
    }
    
    deinit {
        // Shutdown the pool when the class is deinitialized
        self.pool.shutdownGracefully { error in
            if let error = error {
                print("Error shutting down MySQL connection pool: \(error)")
            }
        }
    }
    
    func executeQuery(_ query: String, completion: @escaping (Result<[MySQLRow], Error>) -> Void) {
        pool.withConnection { connection in
            connection.query(query)
        }.whenComplete { result in
            switch result {
            case .success(let rows):
                completion(.success(rows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Optionally, add more methods for specific queries or operations
    // For example, insert, update, delete, etc.
}

