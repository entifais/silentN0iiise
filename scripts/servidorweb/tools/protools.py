from flask import request
import requests
def multrequest(items):	
	values = []
	for item in items:		
		item = request.form.get(item)
		try:
			item = float(item)
		except:	
			item = str(item)
		values.append(item)
	return values
def getImg(url,imgname):
	imgrequ = requests.get(url).content
	with open(imgname, "wb") as file:
		file.write(imgrequ)
