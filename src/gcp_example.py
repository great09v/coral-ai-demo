
from gcp_conn import ConnectGCP

# The name for the new bucket
gcp_conn = ConnectGCP(bucket_name = 'coral-ai')

# Example1  : how to view files
gcp_conn.list_blobs()

# Example2 : how to download files
#gcp_conn.download_blob('ausde.csv','/coral/ausde.csv')
gcp_conn.upload_blob('/coral/ausde.csv', 'ausde_copied.csv')