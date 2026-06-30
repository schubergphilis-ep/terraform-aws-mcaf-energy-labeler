# Changelog

All notable changes to this project will automatically be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v1.0.0 - 2026-06-30

### What's Changed

#### 🚀 Features

* breaking: support AWS provider v6 and resolve deprecation warnings (#19) @marwinbaumannsbp

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.4.0...v1.0.0

## v0.4.0 - 2025-11-11

### What's Changed

#### 🐛 Bug Fixes

* fix: fix the bug that throws the error The argument "statement.5.principals.0.identifiers" is required, but no definition was found. when var.kms_key_arn is defined while var.kms_key_decrypt_iam_principals is empty (#18) @noobnesz

#### 🧺 Miscellaneous

* chore: bump dependencies (#18) @noobnesz

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.3.0...v0.4.0

## v0.3.0 - 2025-09-15

### What's Changed

#### 🚀 Features

* feat: support dedicated kms key (#16) @skesarkar-schubergphilis

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.2.0...v0.3.0

## v0.2.0 - 2024-12-09

### What's Changed

#### 🚀 Features

* feat: Add config option for single account ID (#13) @mikef-nl

#### 🐛 Bug Fixes

* fix: Correct example in `README.md` (#10) @jschilperoord

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.1.4...v0.2.0

## v0.1.4 - 2024-12-02

### What's Changed

#### 🐛 Bug Fixes

* bug: incorrect event role principal (#9) @mlflr

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.1.3...v0.1.4

## v0.1.3 - 2024-10-02

### What's Changed

#### 🐛 Bug Fixes

* bug: allow the task kms permissions (#8) @Plork

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.1.2...v0.1.3

## v0.1.2 - 2024-10-01

### What's Changed

#### 🐛 Bug Fixes

* bug: Remove s3 data resource (#7) @shoekstra

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.1.1...v0.1.2

## v0.1.1 - 2024-10-01

### What's Changed

#### 🐛 Bug Fixes

* bug: Add subnet configuration only if subnets are specified (#6) @shoekstra

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/v0.1.0...v0.1.1

## v0.1.0 - 2024-09-30

### What's Changed

#### 🚀 Features

* First version (#2 #3 #4 #5) @Plork @shoekstra

**Full Changelog**: https://github.com/schubergphilis/terraform-aws-mcaf-energy-labeler/compare/...v0.1.0
