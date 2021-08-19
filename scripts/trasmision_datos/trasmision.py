import socket
class server():
	def __init__(self,address,port):
		self.sock = socket.socket()
		#self.address = address
		#self.port = port
		self.sock.bind((address,port))
		self.conn , self.address =self.sock.accept()
	def sendPause(self,comand = "pause"):
		self.conn.send(comand)
	def sendContinue(self,comand = "continue"):
		self.conn.send(comand)
class testing():
	def __init__(self,address,port,comands = ["pause","continue"]):
		self.sock = socket.socket()
		#self.address = address
		#self.port = port
		self.sock.connect((address,port))
	def recive(self):
		self.sock.listen(1)
		revs = self.sock.recv(1024)
		if revs in commands:
			if revs=="pause":
				print("send pause to audio")
			if revs=="continue":
				print("continue audio")
def testing():
	port = 4092
	address = "localhost"
	while True:
	s = server(address,port)
	t = testing(address,port)
	s.sendPause()
	t.recive()
testing()