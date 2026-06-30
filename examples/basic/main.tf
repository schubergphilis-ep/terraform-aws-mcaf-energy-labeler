provider "aws" {}

module "aws-energy-labeler-single-account" {
  source = "../../"

  config                         = { single_account_id = "123456789012" }
  kms_key_decrypt_iam_principals = ["arn:aws:iam::123456789012:role/MyRole"]
  subnet_ids                     = ["subnet-12345678"]
}

module "aws-energy-labeler-zone" {
  source = "../../"

  config                         = { zone_name = "MYZONE" }
  kms_key_decrypt_iam_principals = ["arn:aws:iam::123456789012:role/MyRole"]
  subnet_ids                     = ["subnet-12345678"]
}
