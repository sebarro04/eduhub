import pyodbc
from decouple import config

SQL_SERVER = config('SQL_SERVER')
SQL_SERVER_DATABASE = config('SQL_SERVER_DATABASE')
SQL_SERVER_USERNAME = config('SQL_SERVER_USERNAME')
SQL_SERVER_PASSWORD = config('SQL_SERVER_PASSWORD')
SQL_SERVER_DRIVER = config('SQL_SERVER_DRIVER')

class Database:
    def __init__(self):
        try:
            self.conn = pyodbc.connect('DRIVER=' + SQL_SERVER_DRIVER +
                            ';SERVER=' + SQL_SERVER +
                            ';DATABASE=' + SQL_SERVER_DATABASE +
                            ';UID=' + SQL_SERVER_USERNAME +
                            ';PWD=' + SQL_SERVER_PASSWORD)
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

    def jsonify_query_result_headers(self, result: list) -> list | Exception:
        try:
            row_headers = [x[0] for x in self.cursor.description]
            json_data = []
            for row in result:
                json_data.append(dict(zip(row_headers, row)))
            return json_data
        except Exception as ex:
            print(ex)
            return ex

if __name__ == '__main__':
    db = Database()