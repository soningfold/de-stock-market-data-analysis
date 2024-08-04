resource "aws_s3_bucket" "demo_bucket" {
  bucket_prefix = var.demo_bucket
  tags = {
    Name        = "Demo bucket for the Kafka stock market data engineering project"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "athena_sql" {
  bucket_prefix = var.athena_sql
  tags = {
    Name        = "Bucket for Athena queries"
    Environment = "Dev"
  }
}