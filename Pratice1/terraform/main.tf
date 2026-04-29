module "network" {
  source = "./modules/network"
}

module "ec2" {
  source = "./modules/ec2"
}

module "security_group" {
  source = "./modules/security_group"
}