import socket


def tcp_client_send_message(message):
    host = "localhost" 
    port = 3301 

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect((host, port))
        s.sendall(message.encode("utf-8"))
        response = s.recv(1024)

    print("Received from the server:", response.decode("utf-8"))


if __name__ == "__main__":
    message = (
        "0.5:0.9"  # Example message
    )
    tcp_client_send_message(message)
