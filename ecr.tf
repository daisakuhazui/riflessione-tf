resource "aws_ecr_repository" "nginx" {
  name = "${var.service_name}-ecr-nginx"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.service_name}-ecr-nginx",
  }
}

resource "aws_ecr_lifecycle_policy" "nginx" {
  repository = "${aws_ecr_repository.nginx.name}"

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["riflessione"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

resource "aws_ecr_repository" "app" {
  name = "${var.service_name}-ecr-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.service_name}-ecr-app",
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = "${aws_ecr_repository.app.name}"

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["riflessione"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
