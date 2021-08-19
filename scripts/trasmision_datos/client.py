import socket
mySocket = socket.socket()
mySocket.conect(('localhost',4826))
mySocket.send("pausar")
response = mySocket.recv(1024)

print(response)