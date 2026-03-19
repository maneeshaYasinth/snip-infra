#------security group for alb--------
resource "aws_security_group" "alb" {
  name = "${var.project}-alb-sg"
  description = "Allow HTTP inbound to ALB"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-alb-sg"
    Project = var.project
    Environment = var.environment
  }

}

#------alb-----------
resource "aws_alb" "main" {
  name = "${var.project}-alb"
  internal = false
  security_groups = [aws_security_group.alb.id]
  subnets = var.public_subnet_ids

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

#------target group to point ecs--------
resource "aws_lb_target_group" "app" {
  name = "${var.project}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

    health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

#-----Listener for ALB to forward traffic to target group------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}