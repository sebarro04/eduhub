from flask import Flask
from blobstorage_flask import BLOBSTORAGE_BLUEPRINT

app = Flask(__name__)

app.register_blueprint(BLOBSTORAGE_BLUEPRINT)

app.secret_key = b'_5#y2L"F4Q8z\n\xec]/' 
UPLOAD_FOLDER = 'C:/Users/sofia/OneDrive/Documentos/Prueba' 
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER 

@app.route("/")
def index():
    return 'Proyecto 01 - Bases De Datos 2'

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug=True)