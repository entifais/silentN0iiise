from flask import Flask, render_template








from tools.protools import getImg ,multrequest
import datetime

app = Flask(__name__)
class webServer():
	WEBADDRESS = "/"
	@app.route(WEBADDRESS)
	def index():
	    return render_template("index.html")
	@app.route(WEBADDRESS+"pelicula")
	def qrAndToken():
	    return render_template("QR.html")
	@app.route(WEBADDRESS+"manage")
	def manage():
		values = ["audiofrom","urlForAudio","nameTag",]
		fileAudioPath = "/static/audio"
		fileName = datetime.datetime.today().strftime("%m/%d/%Y, %H:%M:%S")
		if request.method == 'POST':
			data = multrequest(values)
			if data[0] == "url":
				imageExt = ".jpg"
				getImg(data[1],fileName+"_"data[2]+imageExt)
			if data[0] == "file":
				imgfile = request.files["imgfile"]
				imageExt = getExt(str(imgfile))
				imgfile.save(data[1],fileName+"_"data[2]+imageExt)
	    return render_template("manage.html")
	#upload file 
	#and download 
	#conect to app
	#QR gen for audio
	#when QR read , file download 
	#download form app
	#@app.route(WEBADDRESS+"pause/<string:audioName>")
	#@app.route(WEBADDRESS+"pause/<string:audioName>")

if __name__=='__main__':
    app.run(debug=True,host="0.0.0.0",port=9600)