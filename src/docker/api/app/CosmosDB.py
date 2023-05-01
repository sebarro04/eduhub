from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
import config as cfg

def insert_user_log(user_id, user_action):
    # Authenticate and connect to the cluster
    auth_provider = PlainTextAuthProvider(username=cfg.config['username'], password=cfg.config['password'])
    cluster = Cluster([cfg.config['contactPoint']], port=cfg.config['port'], auth_provider=auth_provider, ssl_context=None)
    session = cluster.connect(cfg.config['keyspace'])
    
    # Insert user log document into 'userlogs' collection
    query = "INSERT INTO userlogs (user_id, user_action) VALUES (%s, %s)"
    session.execute(query, (user_id, user_action))
    
    # Close the session and cluster
    session.shutdown()
    cluster.shutdown()

if __name__ == '__main__':
    print(insert_user_log('123', 'User login into the system'))