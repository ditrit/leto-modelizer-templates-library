resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "bucket"
}

resource "aws_s3_bucket_acl" "aws_s3_bucket_acl" {
  bucket = [aws_s3_bucket.aws_s3_bucket.id]
  acl    = "private"
}
