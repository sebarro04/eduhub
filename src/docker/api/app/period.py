from Database import Database

def read_all_period_statuses() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM period_status'
        db.cursor.execute(query)
        row_headers = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_period_types() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM period_type ORDER BY id'
        db.cursor.execute(query)
        row_headers = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
    except Exception as ex:
        print(ex)
        return ex

def create_period(period_type_id: int, start_date: str, end_date: str, period_status_id: int) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO period (period_type_id, start_date, end_date, period_status_id)
                VALUES (?, ?, ?, ?)
                '''
        db.cursor.execute(query, period_type_id, start_date, end_date, period_status_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def read_all_periods() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT period.id, period_type.name AS period_type, CONVERT(VARCHAR, period.start_date) AS start_date, CONVERT(VARCHAR, period.end_date) AS end_date, period_status.name AS period_status
                FROM period
                INNER JOIN period_type ON period.period_type_id = period_type.id
                INNER JOIN period_status ON period.period_status_id = period_status.id
                '''
        db.cursor.execute(query)
        row_headers = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        json_data = []
        for row in result:
            json_data.append(dict(zip(row_headers, row)))
        return json_data
    except Exception as ex:
        print(ex)
        return ex
    
def update_period(id: int, period_type_id: int | None, start_date: str | None, end_date: str | None, period_status_id: int | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE period
                SET period_type_id = COALESCE(?, period_type_id),
                    start_date = COALESCE(?, start_date),
                    end_date = COALESCE(?, end_date),
                    period_status_id = COALESCE(?, period_status_id)
                WHERE id = ?
                '''
        db.cursor.execute(query, period_type_id, start_date, end_date, period_status_id, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def delete_period(id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE period WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

if __name__ == '__main__':
    periods = read_all_period_types()
    print(periods)
    print('period module')