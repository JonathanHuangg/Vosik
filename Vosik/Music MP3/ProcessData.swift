//
//  ProcessData.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/11/24.
//

import Foundation
// Assuming the definition of `IntensityEntry` is available elsewhere in your code.

class ProcessData {
    private let entries: [IntensityEntry]
    private let completion: () -> Void

    // Add an initializer to set the properties.
    init(entries: [IntensityEntry], completion: @escaping () -> Void) {
        self.entries = entries
        self.completion = completion
    }

    func startProcessing() {
        processNext(index: 0)
    }
    
    private func processNext(index: Int) {
        guard index < entries.count else {
            print("All entries processed!")
            self.completion()
            return
        }
        
        // Example logic for processing each entry
        let entry = entries[index]
        let low = max(entry.percentage - 10, 0)
        let high = min(entry.percentage + 10, 100)
        
        // Simulate processing logic here
        print("Processing entry with name: \(entry.name), low: \(low), high: \(high)")
        
        // Proceed to the next entry
        self.processNext(index: index + 1)
    }
}



//class ProcessData {
//    //private var pool: EventLoopGroupConnectionPool<MySQLConnectionSource>
//    private let entries: [IntensityEntry]
//    private let completion: () -> Void
//    
////    init(hostname: String, port: Int, username: String, password: String, database: String, entries: [IntensityEntry], completion: @escaping () -> Void) {
////        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
////        let configuration = MySQLConfiguration(hostname: hostname, port: port, username: username, password: password, database: database)
////        self.pool = EventLoopGroupConnectionPool(source: MySQLConnectionSource(configuration: configuration), on: eventLoopGroup)
////        self.entries = entries
////        self.completion = completion
////    }
//    
////    deinit {
////        self.pool.shutdownGracefully { error in
////            if let error = error {
////                print("Error shutting down MySQL connection pool: \(error)")
////            }
////        }
////    }
//    
//    func startProcessing() {
//        processNext(index: 0)
//    }
//    
//    private func processNext(index: Int) {
//        guard index < entries.count else {
//            print("All entries processed!")
//            self.completion()
//            return
//        }
//        
//        let entry = entries[index]
//        let low = max(entry.percentage - 10, 0)
//        let high = min(entry.percentage + 10, 100)
//        
//        // Example query to insert/update the entry in a MySQL database
////        let query = "INSERT INTO intensity_entries (name, minutes, percentage_low, percentage_high) VALUES (?, ?, ?, ?)"
////        let values: [MySQLData] = [
////            .init(string: entry.name),
////            .init(int: entry.minutes),
////            .init(int: low),
////            .init(int: high)
////        ]
//        
//        self.processNext(index: index + 1)
//        
//        
////        pool.withConnection { connection in
////            connection.query(query, values)
////        }.whenComplete { result in
////            switch result {
////            case .success(_):
////                print("Entry processed successfully.")
////            case .failure(let error):
////                print("Failed to process entry: \(error)")
////            }
////
////            // Proceed to the next entry
////            self.processNext(index: index + 1)
////        }
//    }
//}
