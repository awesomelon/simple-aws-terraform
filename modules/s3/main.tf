resource "aws_s3_bucket" "s3" {    
    bucket_prefix = var.s3_bucket
}