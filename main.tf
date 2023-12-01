data "aws_vpc" "default_vpc" {
    default = true
}

module sg {
  source = "./modules/security-group"
  vpc_id = data.aws_vpc.default_vpc.id
}

module "s3" {
  source = "./modules/s3"
  s3_bucket = var.s3_bucket
}

module ec2 {
  source = "./modules/ec2"
  ami = var.ami
  key_name = var.key_name
  sg_id = module.sg.sg_id
  instance_name = var.instance_name
  instance_type = var.instance_type
  s3_bucket = module.s3.s3_bucket
}

module lb {
  source = "./modules/lb"
  vpc_id = var.vpc_id
  target_port = 10000
  lb_name = var.lb_name
  domain_name =  var.domain_name
  sub_domain = var.sub_domain
  instance_id = module.ec2.instance_id
}

module route53 {
  source = "./modules/route53"
  sub_domain = var.sub_domain
  domain_name =  var.domain_name
  this_lb = module.lb.this_lb
}