provider "aws" {
  region  = "eu-central-1"
  profile = "cloudgoat"
}

# ====================== STATIC FILES ======================
resource "aws_s3_object" "static_logo" {
  bucket = aws_s3_bucket.bucket.id
  key    = "static/logo.png"
  source = "logo.png"
  etag   = filemd5("logo.png")
}

resource "aws_s3_object" "static_style" {
  bucket = aws_s3_bucket.bucket.id
  key    = "static/style.css"
  source = "style.css"
  etag   = filemd5("style.css")
}

# ====================== SHARED FILES ======================
resource "aws_s3_object" "shared_pixelsync" {
  bucket = aws_s3_bucket.bucket.id
  key    = "shared/PixelSync.ps1"
  source = "PixelSync.ps1"
  etag   = filemd5("PixelSync.ps1")
}

resource "aws_s3_object" "shared_readme" {
  bucket = aws_s3_bucket.bucket.id
  key    = "shared/README.txt"
  source = "README.txt"
  etag   = filemd5("README.txt")
}

# ====================== BADBACKUP FILES ======================
resource "aws_s3_object" "bad_backup_0713" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-13-2025.log"
  source = "backup-agent-07-13-2025.log"
  etag   = filemd5("backup-agent-07-13-2025.log")
}

resource "aws_s3_object" "bad_backup_0714" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-14-2025.log"
  source = "backup-agent-07-14-2025.log"
  etag   = filemd5("backup-agent-07-14-2025.log")
}

resource "aws_s3_object" "bad_backup_0715" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-15-2025.log"
  source = "backup-agent-07-15-2025.log"
  etag   = filemd5("backup-agent-07-15-2025.log")
}

resource "aws_s3_object" "bad_backup_0716" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-16-2025.log"
  source = "backup-agent-07-16-2025.log"
  etag   = filemd5("backup-agent-07-16-2025.log")
}

resource "aws_s3_object" "bad_backup_0717" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-17-2025.log"
  source = "backup-agent-07-17-2025.log"
  etag   = filemd5("backup-agent-07-17-2025.log")
}

resource "aws_s3_object" "bad_backup_0718" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-18-2025.log"
  source = "backup-agent-07-18-2025.log"
  etag   = filemd5("backup-agent-07-18-2025.log")
}

resource "aws_s3_object" "bad_backup_0719" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-07-19-2025.log"
  source = "backup-agent-07-19-2025.log"
  etag   = filemd5("backup-agent-07-19-2025.log")
}

resource "aws_s3_object" "bad_backup_bak" {
  bucket = aws_s3_bucket.bucket.id
  key    = "badBackup/backup-agent-17-07-2025.bak"
  source = "backup-agent-17-07-2025.bak"
  etag   = filemd5("backup-agent-17-07-2025.bak")
}

# ====================== ADMIN FILE ======================
resource "aws_s3_object" "admin_flag" {
  bucket = aws_s3_bucket.bucket.id
  key    = "admin/flag.txt"
  source = "flag.txt"
  etag   = filemd5("flag.txt")
}

# ====================== ROOT FILE ======================
resource "aws_s3_object" "root_index" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "index.html"
  etag   = filemd5("index.html")
}
