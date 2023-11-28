module sg {
  source = "./modules/security-group"
  sg_name = var.sg_name
}

locals {
  api_sub_domain = "${var.sub_domain}-api"
  uploader_sub_domain = "${var.sub_domain}-uploader"  
}

module ec2 {
  source = "./modules/ec2"
  ami = var.ami
  key_name = var.key_name
  sg_id = module.sg.sg_id
  instance_name = var.instance_name
  instance_type = var.instance_type
}

module lb_client {
  source = "./modules/lb"
  vpc_id = var.vpc_id
  target_port = 10000
  lb_name = var.lb_name
  domain_name =  var.domain_name
  sub_domain = var.sub_domain
  instance_id = module.ec2.instance_id
}

module lb_api {
  source = "./modules/lb"
  vpc_id = var.vpc_id
  target_port = 10001
  lb_name = var.lb_name
  domain_name =  var.domain_name
  sub_domain = local.api_sub_domain
  instance_id = module.ec2.instance_id
}

module lb_uploader {
  source = "./modules/lb"
  vpc_id = var.vpc_id
  target_port = 10002
  lb_name = var.lb_name
  domain_name =  var.domain_name
  sub_domain = local.uploader_sub_domain
  instance_id = module.ec2.instance_id
}

module route53_client {
  source = "./modules/route53"
  sub_domain = var.sub_domain
  domain_name =  var.domain_name
  this_lb = module.lb_client.this_lb
}

module route53_api {
  source = "./modules/route53"
  sub_domain = local.api_sub_domain
  domain_name =  var.domain_name
  this_lb = module.lb_api.this_lb
}
module route53_uploader {
  source = "./modules/route53"
  sub_domain = local.uploader_sub_domain
  domain_name =  var.domain_name
  this_lb = module.lb_uploader.this_lb
}