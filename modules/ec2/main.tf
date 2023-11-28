resource "aws_instance" "this" {    
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    ebs_block_device {
        device_name = "/dev/xvda"
        volume_size = 20
    }

    tags = {
        Name = var.instance_name
    }

    vpc_security_group_ids = [
        var.sg_id
    ]  
}