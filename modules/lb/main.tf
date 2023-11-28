resource "aws_lb_target_group" "this_target_group" {
  name = format("%s-%s", var.instance_id, replace("${var.sub_domain}", "/^.*-/", ""))  
  port = var.target_port
  ip_address_type = "ipv4"
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
}


resource "aws_lb_target_group_attachment" "target_group_attach" {
  target_group_arn = aws_lb_target_group.this_target_group.arn
  target_id = var.instance_id
  port = var.target_port
}

data "aws_lb" "this_lb" {
  name = var.lb_name
}

data "aws_lb_listener" "this_lb443" {
  load_balancer_arn = data.aws_lb.this_lb.arn
  port              = 443
}

resource "random_integer" "priority" {
  min = 1
  max = 50000
  keepers = {
    listener_arn = data.aws_lb_listener.this_lb443.arn
  }
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = data.aws_lb_listener.this_lb443.arn
  priority = random_integer.priority.result

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this_target_group.arn
  }
  condition {
    host_header {
      values = ["${var.sub_domain}.${var.domain_name}"]
    }
  }
}