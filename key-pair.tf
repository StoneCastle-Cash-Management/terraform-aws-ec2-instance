module "key-pair" {
  source  = "./modules/key-pair"

  key_pair_name = var.key_name
}
