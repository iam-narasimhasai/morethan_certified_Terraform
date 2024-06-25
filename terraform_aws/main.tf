module "networking" {
  source = "./networking"
  
  cidr_block = var.cidr_block
}