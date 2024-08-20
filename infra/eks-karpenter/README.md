```cmd
aws s3api create-bucket --bucket eks-terraform-2024 --region ap-southeast-2 --create-bucket-configuration LocationConstraint=ap-southeast-2


{
    "Location": "http://eks-terraform-2024.s3.amazonaws.com/"
}

aws s3api put-bucket-versioning --bucket eks-terraform-2024 --versioning-configuration Status=Enabled
```