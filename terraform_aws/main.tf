module "networking" {
  source = "./networking"

  cidr_block = var.cidr_block

  public_cidrs = var.public_cidrs
}