from flask import Flask
from blobstorage_flask import BLOBSTORAGE_BLUEPRINT
from enrollment_flask import ENROLLMENT_BLUEPRINT
from user_role_flask import USER_ROLE_BLUEPRINT

app = Flask(__name__)

app.register_blueprint(BLOBSTORAGE_BLUEPRINT)
app.register_blueprint(ENROLLMENT_BLUEPRINT)
app.register_blueprint(USER_ROLE_BLUEPRINT)

app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

@app.route("/")
def index():
    return 'Proyecto 01 - Bases De Datos 2'

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug=True)