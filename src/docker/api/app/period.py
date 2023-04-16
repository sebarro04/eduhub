from Database import Database

def readAllPeriodStatuses() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM period_status'
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return ex
    
def readAllPeriodTypes() -> list | Exception:
    try:
        db = Database()
        query = 'SELECT id, name FROM period_type ORDER BY id'
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return ex

def createPeriod(periodTypeId: int, startDate: str, endDate: str, periodStatusId: int) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO period (period_type_id, start_date, end_date, period_status_id)
                VALUES (?, ?, ?, ?)
                '''
        db.cursor.execute(query, periodTypeId, startDate, endDate, periodStatusId)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex
    
def readAllPeriods() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT period.id, period_type.name AS period_type, CONVERT(VARCHAR, period.start_date) AS start_date, CONVERT(VARCHAR, period.end_date) AS end_date, period_status.name AS period_status
                FROM period
                INNER JOIN period_type ON period.period_type_id = period_type.id
                INNER JOIN period_status ON period.period_status_id = period_status.id
                '''
        db.cursor.execute(query)
        rowHeaders = [x[0] for x in db.cursor.description]
        result = db.cursor.fetchall()
        jsonData = []
        for row in result:
            jsonData.append(dict(zip(rowHeaders, row)))
        return jsonData
    except Exception as ex:
        return ex
    
def updatePeriod(id: int, periodTypeId: int | None, startDate: str | None, endDate: str | None, periodStatusId: int | None) -> bool | Exception:
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
        db.cursor.execute(query, periodTypeId, startDate, endDate, periodStatusId, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex
    
def deletePeriod(id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE period WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        return ex

if __name__ == '__main__':
    print('period module')