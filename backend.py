import socket
import mysql.connector
from mysql.connector import Error

def connect_to_database():
    """Connect to the MySQL database and return the connection."""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='music',
            user='hacklytics',
            password='mobilize privacy swooned gap blip'
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print("Error while connecting to MySQL", e)
        return None

def handle_client_request(data, connection):
    """
    Handle the client's request by performing a database operation.
    This function is just a placeholder; you'll replace it with your actual database logic.
    """
    parts = data.split(":")
    low = float(parts[0])
    high = float(parts[1])
    cursor = connection.cursor()
    # Example query - adjust according to your needs
    cursor.execute("SELECT * from songs where intensity >= %s and intensity <= %s order by rand();", (low, high))
    result = cursor.fetchone()
    print(result)
    return str(result)

def start_tcp_server():
    host = 'localhost'
    port = 12345  # Choose a port that is free on your system
    
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Listening on port {port}...")
    
    while True:
        client_socket, address = server_socket.accept()
        print(f"Connection from {address} has been established.")
        
        db_connection = connect_to_database()
        if db_connection is not None:
            try:
                data = client_socket.recv(1024).decode('utf-8')
                print(f"Received from client: {data}")
                
                response = handle_client_request(data, db_connection)
                client_socket.sendall(response.encode('utf-8'))
            finally:
                db_connection.close()
        
        client_socket.close()

if __name__ == '__main__':
    start_tcp_server()
