from Database import Database

def create_career(name: str, school_id: str, description: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                INSERT INTO career (name, school_id, description)
                VALUES (?, ?, ?)
                '''
        db.cursor.execute(query, (name, school_id, description))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex    

def read_all_careers() -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT career.id, career.name, school.name AS school_name, career.description
                FROM career
                INNER JOIN school ON career.school_id = school.id
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

def update_career(id: int, name: str | None, school_id: str | None, description: str | None) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE career 
                SET name = COALESCE(?, name),
                    school_id = COALESCE(?, school_id),
                    description = COALESCE(?, description)
                WHERE id = ?
                '''  
        db.cursor.execute(query, (name, school_id, description, id))
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex
    
def delete_career(id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE career WHERE id = ?'
        db.cursor.execute(query, id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return ex

if __name__ == '__main__':
    print(read_all_careers())
    print("module name")