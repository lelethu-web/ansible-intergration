output "instance_detail" {
  value = {
    web_public_ip  = aws_instance.nginxweb.public_ip
  }
}