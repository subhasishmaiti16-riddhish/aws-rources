module "vpc-dev" {
  source = "../child/vpc"
  vpc    = var.vpc-dev
}
module "subnet-dev" {
  depends_on = [module.vpc-dev]
  source     = "../child/subnet"
  subnet     = var.subnet-dev
}
module "security_group-dev" {
  depends_on = [module.vpc-dev]
  source     = "../child/Security_group"
  sg         = var.sg-dev
}
module "ec2-dev" {
  depends_on = [module.subnet-dev, module.security_group-dev]
  source     = "../child/ec2"
  ec2        = var.ec2-dev
}
