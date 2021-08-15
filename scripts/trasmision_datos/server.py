import socket
mySocket = socket.socket()
mySocket.bind(('localhost',4826))
mySocket.listen(2)
conect = True
allAddress = []
while conect:
		conexion,address= mySocket.accept.accept()
		if not address in allAddress:
			allAddress.append(address)