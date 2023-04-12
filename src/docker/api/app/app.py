from flask import Flask
import pyodbc

server = 'tcp:proyecto1-sqlserver.database.windows.net'
database = 'db01'
username = 'el-adm1n'
password = 'dT-Dog01@-bla'
driver = '{ODBC Driver 18 for SQL Server}'

app = Flask(__name__)

@app.route("/")
def hello_world():
    try:
        cnxn = pyodbc.connect('DRIVER=' + driver +
                        ';SERVER=' + server +
                        ';DATABASE=' + database +
                        ';UID=' + username +
                        ';PWD=' + password)

        cursor = cnxn.cursor()
        return "<p>Connection established 5:49!</p>"
    except:  
        return "<p>Cannot connect to SQL server 5:49!</p>"