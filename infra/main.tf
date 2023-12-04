provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Name        = "ForumCD"
    }
  }
}

# resource "aws_instance" "example" {
#   ami           = "ami-007855ac798b5175e" # Ubuntu 22.04 LTS
#   instance_type = "t2.micro"
# 
#   tags = {
#     Name = "terraform-example-instance"
#   }
# }

/* resource "aws_codedeploy_app" "forum" {
  compute_platform = "Server"
  name             = "forum"
} */

resource "aws_lb" "forum" {
  name               = "forum"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.forum.id]

  enable_deletion_protection = true

  /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "forum"
    enabled = true
  } */
}

resource "aws_security_group" "forum" {
    description = "Security group used on the deploy for the Forum project in the 2023/2 class on software construction"
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "ping"
            from_port        = -1
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "icmp"
            security_groups  = []
            self             = false
            to_port          = -1
        },
    ]
    name        = "forum"
}