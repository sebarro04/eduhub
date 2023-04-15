from flask import Flask, Blueprint

app = Flask(__name__)

@app.route("/")
def index():
    return 'Proyecto 01 - Bases De Datos 2'

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug=True)