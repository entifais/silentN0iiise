from flask import request
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
def multrequestStr(items):	
	values = []
	for item in items:		
		item = str(request.form.get(item))
		values.append(item)
	return values