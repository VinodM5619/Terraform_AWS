output "s3_bucket_name" {
  value = aws_s3_bucket.demo.bucket
}

output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

#output "instance_id" {
 # value = aws_instance.demo_instance.id
#}
