locals {
  key_pair_each = var.create_shared_resources ? { shared = true } : {}
  effective_key_name = coalesce(
    try(module.key-pair["shared"].key_pair_name, null),
    var.key_name
  )
}

module "key-pair" {
  source = "./modules/key-pair"

  for_each = local.key_pair_each

  key_pair_name = var.key_name
}
