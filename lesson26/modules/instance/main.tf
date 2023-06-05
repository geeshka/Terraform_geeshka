resource "aws_instance" "this" {
  count = var.instance_count

  ami = data.aws_ami.amazonlinux2.id

  user_data = "${file("user_data.sh")}"

  instance_type = var.type
  key_name      = var.key_name
  root_block_device {
    volume_type           = var.root_disk_type
    volume_size           = var.root_disk_size
    delete_on_termination = true
  }
  tags = {
    Name = var.instance_count == 1 ? var.name : "${var.name}-${count.index}"
  }

 # vpc_security_group_ids = var.security_group_id != "" ? [var.security_group_id] : null
  
  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_iam_policy" "this" {
  name = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "this" {
  name = "Policy Attachement"
  policy_arn = aws_iam_policy.this.arn
  roles       = [aws_iam_role.this.name]
}
