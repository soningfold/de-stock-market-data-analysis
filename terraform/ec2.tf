resource "aws_instance" "kafka-ec2" {
  ami           = "ami-0efebcf6b293598fa"
  instance_type = "t2.micro"
  key_name      = "TestServer"
  vpc_security_group_ids = [aws_security_group.allow_connection.id]
  user_data = file("user_data.sh")
  user_data_replace_on_change = true
  tags = {
    Name = "kafka-ec2"
  }
}