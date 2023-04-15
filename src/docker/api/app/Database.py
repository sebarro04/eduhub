import pyodbc

class Database:
    def __init__(self):
        self.server = 'tcp:proyecto1-sqlserver.database.windows.net'
        self.database = 'db01'
        self.username = 'el-adm1n'
        self.password = 'dT-Dog01@-bla'
        self.driver = '{ODBC Driver 18 for SQL Server}'
        try:
            self.conn = pyodbc.connect('DRIVER=' + self.driver +
                            ';SERVER=' + self.server +
                            ';DATABASE=' + self.database +
                            ';UID=' + self.username +
                            ';PWD=' + self.password)
            self.cursor = self.conn.cursor()
            print('Connection established')
        except Exception as ex:
            print(f'Error connecting to the database: {ex}')
        
    def __del__(self):
        try:
            self.cursor.close()
            self.conn.close()
        except Exception as ex:
            print(ex)

if __name__ == '__main__':
    db = Database()