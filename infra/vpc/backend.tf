#S3
######

terraform {
    backend "s3" {
        bucket = ""
        key = ""
        region = ""
        #dynamodb_table =""
    }
}