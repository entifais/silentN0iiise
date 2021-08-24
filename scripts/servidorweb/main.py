from flask import Flask, render_template
from tools.protools import getImg ,multrequest
import datetime,os
AUDIOPATH = "/static/audio/"
app = Flask(__name__)
class webServer():
	WEBADDRESS = "/"
	@app.route(WEBADDRESS)
	def index():
	    return render_template("index.html")
	@app.route(WEBADDRESS+"pelicula")
	def events():
		#events is name for rediretc to qr for acces for download audio and token for conect 
		filesNames = os.listdir(AUDIOPATH) 
	    return render_template("events.html",audios = filesNames)
	@app.route(WEBADDRESS+"manage")
	def manage():
		values = ["audiofrom","urlForAudio","nameTag",]
		fileName = datetime.datetime.today().strftime("%m/%d/%Y, %H:%M:%S")
		if request.method == 'POST':
			data = multrequest(values)
			if data[0] == "url":
				ext = ".mp3"
				getMp3(data[1],AUDIOPATH+fileName+"_"data[2]+ext)
			if data[0] == "file":
				file = request.files["imgfile"]
				ext = getExt(str(file))
				file.save(data[1],AUDIOPATH+fileName+"_"data[2]+ext)
	    return render_template("manage.html")
	#@app.route('/download/file/<string:filename>')
	#def download_image(filename):
    #	return send_from_directory(os.getcwd() + "/images/", path=filename, as_attachment=True)
	#and download 
	#conect to app
	#QR gen for audio
	#when QR read , file download 
	#download form app
	#@app.route(WEBADDRESS+"pause/<string:audioName>")
	#@app.route(WEBADDRESS+"pause/<string:audioName>")

if __name__=='__main__':
    app.run(debug=True,host="0.0.0.0",port=9600)