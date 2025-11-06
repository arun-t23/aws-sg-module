# AWS Security Group Terraform Module

A reusable, production-ready Terraform module for creating AWS Security Groups with flexible tagging and configuration.

---

## Features

- Creates a security group in a specified VPC
- Configurable name, description, and tags
- Default egress rule allows all outbound traffic
- Consistent naming and tagging using project and environment
- Designed for easy extension with custom ingress/egress rules

---

## Usage

```hcl
module "sg" {
  source      = "github.com/arun-t23/aws-sg-module"
  sg_name     = "web"
  description = "Security group for web servers"
  vpc_id      = "vpc-xxxxxxxx"
  project     = "myproject"
  environment = "dev"
  additional_tags = {
    Owner = "DevOps"
  }
}
```

---

## Requirements

| Name      | Version   |
|-----------|-----------|
| terraform | >= 0.13   |
| aws       | >= 3.0    |

---

## Providers

| Name | Version |
|------|---------|
| aws  | >= 3.0  |

---

## Inputs

| Name            | Description                          | Type          | Default           | Required |
|-----------------|--------------------------------------|---------------|-------------------|:--------:|
| sg_name         | Name for the security group          | `string`      | n/a               | yes      |
| description     | Description for the security group   | `string`      | `"Managed by Terraform"` | no      |
| vpc_id          | VPC ID to create the SG in           | `string`      | n/a               | yes      |
| project         | Project name for tagging/naming      | `string`      | n/a               | yes      |
| environment     | Environment for tagging/naming       | `string`      | n/a               | yes      |
| additional_tags | Additional tags to apply             | `map(string)` | `{}`              | no       |

---

## Outputs

| Name               | Description                        |
|--------------------|------------------------------------|
| security_group_id  | The ID of the created security group |
| security_group_arn | The ARN of the created security group |

---

## Resource Details

- **Resource:** `aws_security_group.main`
  - Name: `${local.common_name_suffix}-${var.sg_name}`
  - Description: `var.description`
  - VPC: `var.vpc_id`
  - Egress: Allows all outbound traffic by default
  - Tags: Merges `project`, `environment`, and any `additional_tags`

---

## Locals

Defined in `locals.tf`:

```hcl
locals {
  common_name_suffix = "${var.project}-${var.environment}"
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }
}
```

---

## Example

```hcl
module "db_sg" {
  source      = "github.com/arun-t23/aws-sg-module"
  sg_name     = "database"
  description = "Security group for RDS"
  vpc_id      = "vpc-xxxxxxx"
  project     = "myproject"
  environment = "prod"
  additional_tags = {
    Owner = "DBA"
  }
}
```

---

## Best Practices

- Use meaningful `sg_name`, `project`, and `environment` values for clarity.
- Add custom ingress/egress rules in your root module as needed.
- Use `additional_tags` for cost allocation or ownership tracking.

---

## Authors

Maintained by Arun T

---
