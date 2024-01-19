

provider "aws" {
  region = "ap-south-1" 
  access_key = "AKIATHRVK5C6ZQPDE46X"
  secret_key = "9/MK6dqEeaP7bgYhAyzVbfsud6GOMDIWMhjnbGqD"
}
resource "aws_instance" "example_instance" {
  ami = "ami-0c84181f02b974bc3"  
  instance_type = "t2.micro"
  key_name = "pradeep"
  count = "1"
  user_data = <<-EOF
              #!/bin/bash
              echo "<html><body><h1>Hello, this is a text page!</h1></body></html>" > /var/www/html/index.html
              yum install -y httpd
              service httpd start
              EOF
}
resource "aws_security_group" "example_sg" {
  name = "example_sg"
  description = "Allow all inbound and outbound traffic"
  ingress {
    from_port = 0
    to_port = 0
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_iam_role" "example_role" {
  name = "example-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_policy" "example_policy" {
  name        = "example-ec2-policy"
  description = "IAM policy for EC2 instance with AmazonFullAccess"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.example_policy.arn
  role       = aws_iam_role.example_role.name
}
resource "aws_s3_bucket" "example_bucket" {
  bucket = "twooftwo"
}

