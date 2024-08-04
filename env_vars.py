from dotenv import load_dotenv
import os

load_dotenv()

PUBLIC_IP = os.getenv('EC2_PUBLIC_IP')
S3_BUCKET_NAME = os.getenv('S3_BUCKET_NAME')
S3_FILE_KEY = os.getenv('S3_FILE_KEY')