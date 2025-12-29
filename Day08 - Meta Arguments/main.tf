
# Reference with var. prefix in main.tf
resource "aws_s3_bucket" "demo" {
  count = 2
  bucket = var.bucket_names[count.index] # Using input variable
  
  tags = var.tags
}

resource "aws_s3_bucket" "demo2" {
  for_each = var.bucket_name_set
  bucket = each.key # Using input variable
  
  tags = var.tags

  depends_on = [ aws_s3_bucket.demo ]
}
