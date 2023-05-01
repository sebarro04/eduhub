from werkzeug.datastructures import FileStorage
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient
from decouple import config
from datetime import datetime
import os
from Database import Database

BLOB_STORAGE_URL = config('BLOB_STORAGE_URL')
DEFAULT_CREDENTIAL = DefaultAzureCredential(exclude_shared_token_cache_credential = True, exclude_visual_studio_code_credential = True, exclude_powershell_credential = True)
BLOB_SERVICE_CLIENT = BlobServiceClient(BLOB_STORAGE_URL, credential=DEFAULT_CREDENTIAL)

def create_file_url(filename: str, current_time_ms: int) -> str:
    name = os.path.splitext(filename)[0] # get filename without extension
    ext = os.path.splitext(filename)[1] # get file extension
    return name + f'-{current_time_ms}' + ext # file url

def create_file(filename: str, description: str | None, file_url: str, user_id: str, creation_datetime: datetime | str) -> bool | Exception:
    try:
        db = Database()
        if description != '':
            query = 'INSERT INTO [file] (name, description, url, user_id, creation_datetime) VALUES (?, ?, ?, ?, ?)'
            db.cursor.execute(query, filename, description, file_url, user_id, creation_datetime)
        else:
            query = 'INSERT INTO [file] (name, url, user_id, creation_datetime) VALUES (?, ?, ?, ?)'
            db.cursor.execute(query, filename, file_url, user_id, creation_datetime)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return Exception('Error inserting the file data to the database')
    
def read_file_url(file_id: int) -> str | Exception:
    try:
        db = Database()
        query = 'SELECT url FROM [file] WHERE id = ?'
        db.cursor.execute(query, file_id)
        return db.cursor.fetchall()[0][0] # file url
    except Exception as ex:
        print(ex)
        return Exception('Error reading the file url from the database ')
    
def read_filename(file_id: int) -> str | Exception:
    try:
        db = Database()
        query = 'SELECT name FROM [file] WHERE id = ?'
        db.cursor.execute(query, file_id)
        return db.cursor.fetchall()[0][0] # return result query
    except Exception as ex:
        print(ex)
        return Exception('Error reading the filename from the database')
    
def read_latest_files(user_id: str) -> list | Exception:
    try:
        db = Database()
        query = '''
                WITH cte AS (
                    SELECT id, name, description, creation_datetime, last_modified_datetime, ROW_NUMBER() OVER (PARTITION BY name ORDER BY creation_datetime DESC) AS rn
                    FROM [file]
                    WHERE user_id = ?
                )
                SELECT id, name, description, CONVERT(VARCHAR, creation_datetime, 126) AS creation_datetime, CONVERT(VARCHAR, last_modified_datetime, 126) AS last_modified_datetime
                FROM cte
                WHERE rn = 1
                '''
        db.cursor.execute(query, user_id)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return Exception('Error reading the file data from the database')
    
def read_file_history(file_id: int) -> list | Exception:
    try:
        db = Database()
        query = '''
                SELECT id, name, description, CONVERT(VARCHAR, creation_datetime, 126) AS creation_datetime, CONVERT(VARCHAR, last_modified_datetime, 126) AS last_modified_datetime
                FROM [file]
                WHERE name = (SELECT name FROM [file] WHERE id = ?)
                ORDER BY creation_datetime DESC
                '''
        db.cursor.execute(query, file_id)
        result = db.cursor.fetchall()
        return db.jsonify_query_result_headers(result)
    except Exception as ex:
        print(ex)
        return Exception('Error reading the file data from the database')
    
def update_file_description(file_id: int, file_description: str) -> bool | Exception:
    try:
        db = Database()
        query = '''
                UPDATE [file]
                set description = ?,
                    last_modified_datetime = ?
                WHERE id = ?
                '''
        db.cursor.execute(query, file_description, datetime.now(), file_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return Exception('Error updating the file description in the database')
    
def delete_file(file_id: int) -> bool | Exception:
    try:
        db = Database()
        query = 'DELETE [file] WHERE id = ?'
        db.cursor.execute(query, file_id)
        db.cursor.commit()
        return True
    except Exception as ex:
        print(ex)
        return Exception('Error deleting the file data from the database')

def upload_blob(file: FileStorage, file_url: str) -> bool | Exception:
    try:
        blob_client = BLOB_SERVICE_CLIENT.get_blob_client(container='documents', blob=file_url) 
        blob_client.upload_blob(file)
        return True
    except Exception as ex:
        print(ex)
        return Exception('Error uploading the file to Azure')

def download_blob(file_id: int) -> bytes | Exception:
    try:       
        file_url = read_file_url(file_id)
        if isinstance(file_url, Exception):
            return file_url
        blob_client = BLOB_SERVICE_CLIENT.get_blob_client(container='documents', blob=file_url)
        return blob_client.download_blob().readall() # blob bytes
    except Exception as ex:
        print(ex)
        return Exception('Error downloading the file from Azure')
    
def delete_blob(file_id: int) -> bool | Exception:
    try:
        file_url = read_file_url(file_id)
        blob_client = BLOB_SERVICE_CLIENT.get_blob_client(container='documents', blob=file_url) 
        blob_client.delete_blob()      
        return True
    except Exception as ex:
        print(ex)
        return Exception('Error deleting the file from Azure')
    
if __name__ == '__main__':
    print(read_file_url(-1))