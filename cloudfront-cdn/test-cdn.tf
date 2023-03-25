#############################
# Only for tests purposes
# Upload one HTML file to S3
#############################
resource "aws_s3_object" "public_folder" {
  for_each     = fileset("public/", "*")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "public/${each.value}"
  etag         = filemd5("public/${each.value}")
  content_type = "text/html"
}

#############################
# Only for tests purposes
# Invalidate index.html from CloudFront cache
#############################
resource "null_resource" "cache_invalidation" {

  # prevent invalidating cache before new s3 file is uploaded
  depends_on = [
    aws_s3_object.public_folder
  ]

  for_each = fileset("${path.module}/public/", "**")

  triggers = {
    hash = filemd5("public/${each.value}")
  }

  provisioner "local-exec" {
    # sleep is necessary to prevent throttling when invalidating many files; a dynamic sleep time would be more reliable
    # possible way of dealing with parallelism (though would lose the indiviual triggers): https://discuss.hashicorp.com/t/specify-parallelism-for-null-resource/20884/2
    command = "sleep 1; aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.cloudfront.id} --paths '/${each.value}'"
  }
}
