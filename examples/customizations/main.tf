locals {
  instances = {
    "01" = { subnet_id = "subnet-004bd50c208ef9da6", sg_ids = ["sg-07b4edce8a1a6eb24"] }
    "02" = { subnet_id = "subnet-04cfe85913b3af630", sg_ids = ["sg-07b4edce8a1a6eb24"] }
  }
}

module "instance" {
  source = "../../"

  for_each = local.instances

  application             = "exampleapp"
  create_shared_resources = each.key == "01"
  environment             = "dev"
  ami_os                  = "Amazon_Linux"
  instance_number         = each.key
  instance_type           = "r5.large"
  key_name                = "example_key"
  vpc_security_group_ids  = each.value.sg_ids
  subnet_id               = each.value.subnet_id
  root_block_device = [
    {
      encrypted  = true
      kms_key_id = "arn:aws:kms:us-east-1:521938783116:key/e3203821-6efd-4848-9a8c-50a9990e06cd"
    }
  ]
}

