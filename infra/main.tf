provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project        = "ForumCD"
    }
  }
}

resource "aws_instance" "forum" {
  ami           = "ami-007855ac798b5175e" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  subnet_id     = element(module.vpc.public_subnets, 0)
}

/* resource "aws_codedeploy_app" "forum" {
  compute_platform = "Server"
  name             = "forum"
} */

resource "aws_security_group" "forum" {
    description = "Security group used on the deploy for the Forum project in the 2023/2 class on software construction"
    vpc_id      = module.vpc.vpc_id
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "egress from ec2"
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
            description      = "ssh access"
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
            description      = "https requests"
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
            description      = "http requests"
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

/* resource "aws_db_instance" "forum" {
  allocated_storage = 5
  engine = "postgres"
  instance_class = "db.t3.micro"
  username = "forum"
  password = "foobarbaz"
  db_subnet_group_name = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.forum.id]

  skip_final_snapshot = true // required to destroy
} */

module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "forumCD"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  create_security_group = false
  security_groups = [aws_security_group.forum.id]

  listeners = {
    forum-http = {
      port            = 80
      protocol        = "HTTP"
      forward = {
        target_group_key = "forum"
      }
    }
  }

  target_groups = {
    forum = {
      name_prefix      = "h1"
      protocol         = "HTTP"
      port             = 80
      target_type      = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-404"
      }

      protocol_version = "HTTP1"
      target_id        = aws_instance.forum.id
      port             = 80
    }
  }
}