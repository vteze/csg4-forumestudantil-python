terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "aws-labo" {
  ami           = "ami-01bc990364452ab3e" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  subnet_id     = subnet-0fe5c2b005939f49b
}

/* resource "aws_codedeploy_app" "aws-labo" {
  compute_platform = "Server"
  name             = "aws-labo"
} */

resource "aws_codedeploy_deployment_group" "csg4_forumestudantil_deployment_group" {
  app_name              = aws_codedeploy_app.csg4_forumestudantil_application.name
  deployment_group_name = "csg4-forumestudantil-deployment-group"
  service_role_arn      = "arn:aws:iam::813303321040:role/LabRole"

  autoscaling_groups = [
		aws_autoscaling_group.vtz.name
	]

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

}

resource "aws_security_group" "aws-labo" {
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
    name        = "aws-labo"
}

/* resource "aws_db_instance" "aws-labo" {
  allocated_storage = 5
  engine = "postgres"
  instance_class = "db.t3.micro"
  username = "aws-labo"
  password = "foobarbaz"
  db_subnet_group_name = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.aws-labo.id]

  skip_final_snapshot = true // required to destroy
} */

module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "csg4-forumestudantil"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  create_security_group = false
  security_groups = [aws_security_group.aws-labo.id]

  listeners = {
    aws-labo-http = {
      port            = 80
      protocol        = "HTTP"
      forward = {
        target_group_key = "aws-labo"
      }
    }
  }

  target_groups = {
    aws-labo = {
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
      target_id        = aws_instance.aws-labo.id
      port             = 80
    }
  }
}