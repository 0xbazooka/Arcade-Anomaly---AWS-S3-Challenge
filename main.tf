provider "aws" {
  region  = "eu-central-1"
  profile = "cloudgoat"
}

# Create unique S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "my-baz00ka-bucket-20250717" # must be globally unique
}

# Allow public access (needed for public folders)
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Make static/ and shared/ publicly accessible + allow listing entire bucket
resource "aws_s3_bucket_policy" "public_static_and_shared" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadAccessStaticShared",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = [
          "${aws_s3_bucket.bucket.arn}/static/*",
          "${aws_s3_bucket.bucket.arn}/shared/*"
        ]
      },
      {
        Sid       = "AllowPublicListRootStaticShared",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:ListBucket",
        Resource  = "${aws_s3_bucket.bucket.arn}",
        Condition = {
          StringLike = {
            "s3:prefix" = [
              "",
              "static/",
              "shared/"
            ]
          },
          StringEquals = {
            "s3:delimiter" = "/"
          }
        }
      },
      {
        Sid       = "AllowAnonymousListBadBackup",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:ListBucket",
        Resource  = "${aws_s3_bucket.bucket.arn}",
        Condition = {
          StringLike = {
            "s3:prefix" = "badBackup/*"
          }
        }
      }
    ]
  })
}



# ========== IAM: badUser access to badBackup/ ==========

resource "aws_iam_policy" "bad_user_access_to_backup" {
  name = "BadUserAccessToBackup"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowListBadBackup",
        Effect = "Allow",
        Action = "s3:ListBucket",
        Resource = aws_s3_bucket.bucket.arn,
        Condition = {
          StringLike = {
            "s3:prefix" = "badBackup/*"
          }
        }
      },
      {
        Sid    = "AllowReadBadBackupOnly",
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.bucket.arn}/badBackup/*"
      }
    ]
  })
}


resource "aws_iam_user_policy_attachment" "bad_user_attach" {
  user       = "badUser" # assumes the IAM user already exists
  policy_arn = aws_iam_policy.bad_user_access_to_backup.arn
}

# ========== IAM: badAdmin access to admin/ ==========

resource "aws_iam_policy" "bad_admin_access_to_admin" {
  name = "BadAdminAccessToAdmin"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowListAdmin",
        Effect = "Allow",
        Action = "s3:ListBucket",
        Resource = aws_s3_bucket.bucket.arn,
        Condition = {
          StringLike = {
            "s3:prefix" = "admin/*"
          }
        }
      },
      {
        Sid    = "AllowBadAdminAccessToAdminObjects",
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = "${aws_s3_bucket.bucket.arn}/admin/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "bad_admin_attach" {
  user       = "badAdmin" # assumes the IAM user already exists
  policy_arn = aws_iam_policy.bad_admin_access_to_admin.arn
}

# Create "folders" by uploading empty objects with trailing slashes

resource "aws_s3_object" "static_dir" {
  bucket  = aws_s3_bucket.bucket.id
  key     = "static/"
  content = ""
}

resource "aws_s3_object" "shared_dir" {
  bucket  = aws_s3_bucket.bucket.id
  key     = "shared/"
  content = ""
}

resource "aws_s3_object" "bad_backup_dir" {
  bucket  = aws_s3_bucket.bucket.id
  key     = "badBackup/"
  content = ""
}

resource "aws_s3_object" "admin_dir" {
  bucket  = aws_s3_bucket.bucket.id
  key     = "admin/"
  content = ""
}
