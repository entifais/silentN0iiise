from flask import Flask, render_template
app = Flask(__name__)
@app.route("/")
def index():
    return render_template("index.html")
@app.route("/"+"pelicula")
def qrAndToken():
    return render_template("QR.html")
@app.route("/")
def manage():
	#get file or url
	values = ["fileAudio","urlForAudio","audiofrom"]
	if request.method == 'POST':
		data = multrequest(values)
    return render_template("manage.html")
if __name__=='__main__':
    app.run(debug=True,host="0.0.0.0",port=9600)