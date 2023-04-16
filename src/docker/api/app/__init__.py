from flask import Flask, Blueprint
from period_flask import PERIOD_BLUERPRINT
from school_flask import SCHOOL_BLUERPRINT
from class_rating_flask import CLASS_RATING_BLUERPRINT

app = Flask(__name__)
app.register_blueprint(PERIOD_BLUERPRINT)
app.register_blueprint(SCHOOL_BLUERPRINT)
app.register_blueprint(CLASS_RATING_BLUERPRINT)

@app.route("/")
def index():
    return 'Proyecto 01 - Bases De Datos 2'

if __name__ == '__main__':
    app.run(host = '0.0.0.0', debug=True)