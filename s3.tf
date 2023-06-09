data "aws_iam_policy_document" "website" {
  statement {
    actions   = ["s3:GetObject"]
    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/*"]
    effect = "Allow"
  }
}

resource "aws_s3_bucket" "website" {
  bucket = local.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website.json
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

## Website files
resource "aws_s3_object" "data" {
  for_each = fileset("www-data", "**/*")

  bucket = aws_s3_bucket.website.bucket
  key    = each.value
  source = "www-data/${each.value}"
  content_type = "text/html"
}
