variable "AWS_REGION" {
  default = "us-east-2"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "sree-key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "sree-key.pub"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-2 = "ami-059d836af932792c3"
    us-west-2 = "ami-0a7d051a1c4b54f65"
    eu-west-1 = "ami-04c58523038d79132"
  }
}
variable "PUBLIC_IP" {
 default = "public_ip"
}
