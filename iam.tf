resource "aws_iam_role" "ecs_task_execution" {
  name               = "ecs-task-execution-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_role_policy.arn
}

data "aws_iam_policy" "ssm_readonly" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "task_execution_ssm_readonly" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = data.aws_iam_policy.ssm_readonly.arn
}

resource "aws_iam_role" "ecs_task" {
  name               = "ecs-task-role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

data "aws_iam_policy" "s3_full" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "task_s3_full" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = data.aws_iam_policy.s3_full.arn
}
