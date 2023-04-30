import json
import pydocumentdb.document_client as document_client
import datetime

# Configurar el cliente de Azure Cosmos DB
uri = 'https://tfex-cosmos-db-98560.documents.azure.com:443/'
clave = 'jFaGMKu4HG5lBSmYsQmB01hBGhBtXziNoAqDTiNOMuLvmSXEvxfSEUkmVNLfX2OFR1mRvj8Q5GxwACDbZH1qrg=='
cliente = document_client.DocumentClient(uri, {'masterKey': clave})

# Crear un objeto JSON con la acción del usuario
user_action = {
    'userId': 'I4jurZC2gpNEvpnWGb9iYQkVpXy1',
    'action': 'Consulto las matriculas disponibles asociadas a su id de estudiante',
    'timestamp': datetime.datetime.utcnow().isoformat()
}

# Convertir el objeto JSON a un documento JSON
documento_json = json.dumps(user_action)

# Convertir el documento JSON a un diccionario
documento_dict = json.loads(documento_json)

# Crear el documento en Azure Cosmos DB
coleccion_enlace = 'dbs/tfex-cosmos-cassandra-keyspace/colls/userlogs'
cliente.CreateDocument(coleccion_enlace, documento_dict)


