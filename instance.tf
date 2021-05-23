resource "aws_instance" "sridhar-ec2" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  
# the VPC subnet
  subnet_id = aws_subnet.sridhar-public.id
  
# the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  
# the public SSH key
  key_name = aws_key_pair.sree-key.key_name
  tags = {
	Name = "Sridhar-ansible"
  }

provisioner "remote-exec" {
  inline = ["echo 'build ssh connection' >> /tmp/file "]
  connection {
	host = self.public_ip
	type = "ssh"
	user = "ubuntu"
	private_key = file("./sree-key")

 }
}
provisioner "local-exec" {
	command = "ansible-playbook -i ${aws_instance.sridhar-ec2.public_ip}, --private-key ${var.PATH_TO_PRIVATE_KEY} provisioner.yaml -b"
 }

}
