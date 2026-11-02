module "vpc-dev" {
  source = "../child/vpc"
  vpc    = var.vpc-dev
}
module "subnet-dev" {
  depends_on = [module.vpc-dev]
  source     = "../child/subnet"
  subnet     = var.subnet-dev
}
