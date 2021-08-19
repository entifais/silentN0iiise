import socket
class server():
	def __init__(self,address,port):
		self.sock = socket.socket()
		#self.address = address
		#self.port = port
		self.sock.conect((address,port))
	def sendPause(self):
	def sendContinue(self):
class testing():
	def __init__(self,address,port,comands = ["pause","continue"]):
		self.sock = socket.socket()
		#self.address = address
		#self.port = port
		self.sock.conect((address,port))
	def recive(self):
		self.sock.listen(1)
		revs = self.sock.recv(1024)
		if revs in commands:
			
