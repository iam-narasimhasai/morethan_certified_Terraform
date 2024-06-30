module "networking" {
  source = "./networking"

  cidr_block = var.cidr_block

  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  ports         = var.ports
  pr_ports      = var.pr_ports
  dbsgbool      = var.dbsgbool
}

module "database" {
  source                 = "./database"
  db_storage             = var.db_storage
  db_engine_version      = var.db_engine_version
  db_instance_class      = var.db_instance_class
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  vpc_security_group_ids = module.networking.db

  db_subnet_group_name   = module.networking.dbsecuritygroup[0]
  
  db_identifier          = var.db_identifier
  skip_db_snapshot       = var.skip_db_snapshot

}

