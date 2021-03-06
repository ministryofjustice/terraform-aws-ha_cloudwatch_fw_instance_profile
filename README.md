## EC2 IAM Instance Profile
### Overview
This module simplifies the createion of the required IAM instance profiles for Palo Alto VM Series Firewalls on AWS to enable custom cloud watch metrics and/or HA capability.

### Caveats
None

### Usaage
```
provider "aws" {
  region = var.region
}

module "iam_profile" {
  source    = "../../"
  name      = var.name
  enable_cw = true
  enable_ha = true
}
```
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.7 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bs\_bucket | name of bootstrap bucket | `string` | `""` | no |
| enable\_bs | Enable for boostrap bucket IAM policy | `bool` | `false` | no |
| enable\_cw | Enable for CW IAM policy | `bool` | `false` | no |
| enable\_ha | Enable for HA IAM policy | `bool` | `false` | no |
| enable\_cl | Enable for cloud logging IAM policy | `bool` | `true` | no |
| name | Name to prepend to IAM resources | `string` | `"palo"` | no |

## Outputs

| Name | Description |
|------|-------------|
| iam\_instance\_profile\_name | IAM instance profile name |
