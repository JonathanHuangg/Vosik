//
//  TCP Socket.swift
//  Vosik
//
//  Created by Jonathan Huang on 2/10/24.
//

import Network

// Define host and port

let host = NWEndpoint.Host("168.61.19.240")
let port = NWEndpoint.Port(integerLiteral: 12345)

// connect to server

let connection = NWConnection(host: host, port: port, using: .tcp)

// Start connection
//connection.start(queue: <#DispatchQueue#>)

let messageToSend = "0.1:0.2"
