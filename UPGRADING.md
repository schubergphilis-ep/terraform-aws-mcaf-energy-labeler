# Upgrading Notes

This document captures required refactoring on your part when upgrading to a module version that contains breaking changes.

## Upgrading to v1.0.0

### Key Changes

- This module now requires a minimum AWS provider version of `6.0`. The `name` attribute of the `aws_region` data source was deprecated in AWS provider `6.0` in favor of `region`, and the child modules bundled with this module now require provider `6.x`. If you are using multiple AWS provider blocks, please read [migrating from multiple provider configurations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/enhanced-region-support#migrating-from-multiple-provider-configurations).
- The bundled `schubergphilis/mcaf-s3/aws` module has been upgraded from `~> 1.5.2` to `~> 3.0.0`. As of `3.0.0`, server-side encryption with customer-provided keys (`SSE-C`) is blocked by default. This module encrypts the bucket with a KMS key (`SSE-KMS`), so this change has no functional impact on the energy labeler.
- The bundled `terraform-aws-modules/ecs/aws//modules/container-definition` module has been upgraded from `~> 5.12.1` to `~> 7.5.0`.
- Sync internal KMS key policy with latest version from the [mcaf-kms](https://github.com/schubergphilis/terraform-aws-mcaf-kms/blob/master/UPGRADING.md#upgrading-to-v200) module, the internal key policy of the module cannot be used due to a cyclic dependency issue.

### Required Actions

- Ensure the AWS provider used in the calling configuration is `>= 6.0`.
- No changes to this module's input variables or outputs are required.
