locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  region     = data.aws_region.current.region

  # If no administrators are specified, fall back to the current caller so the key
  # never ends up without a principal able to manage it.
  iam_administrator = coalescelist(var.kms_key_administrator_iam_principals, [data.aws_iam_session_context.current.issuer_arn])
}

data "aws_iam_policy_document" "kms_key_policy" {
  # checkov:skip=CKV_AWS_111: Ensure IAM policies does not allow write access without constraints - False positive, this is a KMS key policy
  # checkov:skip=CKV_AWS_356: Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions - False positive, this is a KMS key policy
  # checkov:skip=CKV_AWS_109: Ensure IAM policies does not allow permissions management / resource exposure without constraints - False positive, this is a KMS key policy

  statement {
    sid       = "Base Permissions for root user"
    actions   = ["kms:*"]
    effect    = "Allow"
    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"
      values   = ["Account"]
    }

    principals {
      type        = "AWS"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid       = "Read/List permissions for all IAM users"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Describe*",
      "kms:GetKeyPolicy",
      "kms:ListAliases",
      "kms:ListKeys"
    ]


    principals {
      type        = "AWS"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid       = "Administrative permissions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:CancelKeyDeletion",
      "kms:Create*",
      "kms:Delete*",
      "kms:Describe*",
      "kms:Disable*",
      "kms:Enable*",
      "kms:Get*",
      "kms:ImportKeyMaterial",
      "kms:List*",
      "kms:Put*",
      "kms:ReplicateKey",
      "kms:Revoke*",
      "kms:RotateKeyOnDemand",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:Update*"
    ]

    principals {
      type        = "AWS"
      identifiers = local.iam_administrator
    }
  }

  statement {
    sid       = "Permissions for Cloudwatch log group"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Decrypt",
      "kms:Describe*",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"

      values = [
        "arn:aws:logs:${local.region}:${local.account_id}:log-group:/aws/ecs/${var.name}"
      ]
    }
  }

  statement {
    sid       = "Permissions for energy labeler ECS task role"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]

    principals {
      type        = "AWS"
      identifiers = [module.iam_role["task"].arn]
    }
  }

  statement {
    sid       = "Permissions to Decrypt for specified IAM principals"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Decrypt"
    ]

    principals {
      type        = "AWS"
      identifiers = var.kms_key_decrypt_iam_principals
    }
  }
}

module "kms_key" {
  count = var.kms_key_arn == null ? 1 : 0

  source  = "schubergphilis/mcaf-kms/aws"
  version = "~> 2.2.0"

  name           = var.name
  default_policy = { enable = false }
  description    = "KMS key used for encrypting all energy labeler resources"
}

resource "aws_kms_key_policy" "default" {
  count = var.kms_key_arn == null ? 1 : 0

  key_id = module.kms_key[0].id
  policy = data.aws_iam_policy_document.kms_key_policy.json
}
