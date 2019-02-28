# Imports the Google Cloud client library
from google.cloud import storage


class ConnectGCP():
        def __init__(self, bucket_name):
                self.bucket_name = bucket_name

        def download_blob(self, source_blob_name, destination_file_name):
                """Downloads a blob from the bucket."""
                storage_client = storage.Client()
                bucket = storage_client.get_bucket(self.bucket_name)
                blob = bucket.blob(source_blob_name)

                blob.download_to_filename(destination_file_name)

                print('Blob {} downloaded to {}.'.format(
                        source_blob_name,
                        destination_file_name))

        def upload_blob(self, source_file_name, destination_blob_name):
                """Uploads a file to the bucket."""
                storage_client = storage.Client()
                bucket = storage_client.get_bucket(self.bucket_name)
                blob = bucket.blob(destination_blob_name)

                blob.upload_from_filename(source_file_name)

                print('File {} uploaded to {}.'.format(
                        source_file_name,
                        destination_blob_name))

        def list_blobs(self):
                """Lists all the blobs in the bucket."""
                storage_client = storage.Client()
                bucket = storage_client.get_bucket(self.bucket_name)

                blobs = bucket.list_blobs()

                for blob in blobs:
                        print(blob.name)
