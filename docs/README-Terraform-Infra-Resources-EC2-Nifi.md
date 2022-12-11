<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63.0, < 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ../../../../../../../modules/providers/aws/officials/terraform-aws-s3-bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nifi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_elb.nifi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.nifi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.nifi_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route53_record.nifi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.nifi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |
| [aws_cloudfront_log_delivery_canonical_user_id.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_log_delivery_canonical_user_id) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.cmk_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_subnet_ids.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.core_state](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_my_ip"></a> [access\_my\_ip](#input\_access\_my\_ip) | Your IP Address | `string` | `"118.136.0.0/22"` | no |
| <a name="input_ami_aws_linux"></a> [ami\_aws\_linux](#input\_ami\_aws\_linux) | AWS Linux AMI to use.  Must match availability zone, instance type, etc | `string` | `"ami-0dc5785603ad4ff54"` | no |
| <a name="input_ami_os"></a> [ami\_os](#input\_ami\_os) | Selected OS AMI | `string` | `"aws-linux"` | no |
| <a name="input_ami_ubuntu"></a> [ami\_ubuntu](#input\_ami\_ubuntu) | Ubuntu Linux AMI to use.  Must match availability zone, instance type, etc | `string` | `"ami-0fed77069cd5a6d6c"` | no |
| <a name="input_aws_az"></a> [aws\_az](#input\_aws\_az) | AWS Zone Target Deployment | `map(string)` | <pre>{<br>  "lab": "ap-southeast-1a",<br>  "prod": "ap-southeast-1b",<br>  "staging": "ap-southeast-1b"<br>}</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region Target Deployment | `string` | `"ap-southeast-1"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket Name | `string` | `"devopscorner-nifi"` | no |
| <a name="input_department"></a> [department](#input\_department) | Department Owner | `string` | `"DEVOPS"` | no |
| <a name="input_dns_url"></a> [dns\_url](#input\_dns\_url) | n/a | `map(string)` | <pre>{<br>  "lab": "awscb.id",<br>  "prod": "awscb.id",<br>  "staging": "awscb.id"<br>}</pre> | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | ------------------------------------ DNS (Public) ------------------------------------ | `map(string)` | <pre>{<br>  "lab": "ZONE_ID",<br>  "prod": "ZONE_ID",<br>  "staging": "ZONE_ID"<br>}</pre> | no |
| <a name="input_ebs_content_repo_size"></a> [ebs\_content\_repo\_size](#input\_ebs\_content\_repo\_size) | EBS size for nifi content repository | `number` | `100` | no |
| <a name="input_ebs_flowfile_repo_size"></a> [ebs\_flowfile\_repo\_size](#input\_ebs\_flowfile\_repo\_size) | EBS size for nifi flowfile repository | `number` | `50` | no |
| <a name="input_ebs_opt_data_size"></a> [ebs\_opt\_data\_size](#input\_ebs\_opt\_data\_size) | EBS size for /opt/data folder | `number` | `100` | no |
| <a name="input_ebs_provenance_repo_size"></a> [ebs\_provenance\_repo\_size](#input\_ebs\_provenance\_repo\_size) | EBS size for nifi provenance repository | `number` | `100` | no |
| <a name="input_ebs_root_size"></a> [ebs\_root\_size](#input\_ebs\_root\_size) | EBS size for root OS | `number` | `50` | no |
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | Nifi Name | `string` | `"nifi"` | no |
| <a name="input_ec2_type"></a> [ec2\_type](#input\_ec2\_type) | Nifi EC2 Instance Type | `map(string)` | <pre>{<br>  "lab": "t3.medium",<br>  "prod": "t3.medium",<br>  "staging": "t3.medium"<br>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Workspace Environment Selection | `map(string)` | <pre>{<br>  "lab": "lab",<br>  "prod": "prod",<br>  "staging": "staging"<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Target Environment (tags) | `map(string)` | <pre>{<br>  "lab": "RND",<br>  "prod": "PROD",<br>  "staging": "STG"<br>}</pre> | no |
| <a name="input_kms_env"></a> [kms\_env](#input\_kms\_env) | KMS Key Environment | `map(string)` | <pre>{<br>  "lab": "RnD",<br>  "prod": "Production",<br>  "staging": "Staging"<br>}</pre> | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | KMS Key References | `map(string)` | <pre>{<br>  "lab": "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH",<br>  "prod": "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH",<br>  "staging": "arn:aws:kms:ap-southeast-1:YOUR_AWS_ACCOUNT:key/CMK_KEY_HASH"<br>}</pre> | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH Public Key | `string` | `""` | no |
| <a name="input_tfstate_bucket"></a> [tfstate\_bucket](#input\_tfstate\_bucket) | Name of bucket to store tfstate | `string` | `"devopscorner-terraform-remote-state"` | no |
| <a name="input_tfstate_dynamodb_table"></a> [tfstate\_dynamodb\_table](#input\_tfstate\_dynamodb\_table) | Name of dynamodb table to store tfstate | `string` | `"devopscorner-terraform-state-lock"` | no |
| <a name="input_tfstate_encrypt"></a> [tfstate\_encrypt](#input\_tfstate\_encrypt) | Name of bucket to store tfstate | `bool` | `true` | no |
| <a name="input_tfstate_path"></a> [tfstate\_path](#input\_tfstate\_path) | Path .tfstate in Bucket | `string` | `"resources/nifi/terraform.tfstate"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_route53"></a> [route53](#output\_route53) | n/a |
<!-- END_TF_DOCS -->