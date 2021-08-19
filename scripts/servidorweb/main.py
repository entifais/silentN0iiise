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
		return render_template("manage.html")
if __name__=='__main__':
	webapp.run(debug=True,host="0.0.0.0",port=9600)