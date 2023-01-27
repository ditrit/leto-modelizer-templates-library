resource "aws_security_group" "SecurityGroup" {
    vpc_id = ["VPC"]
}

resource "aws_vpc" "VPC" {
}

resource "aws_internet_gateway" "InternetGateway" {
    vpc_id = "VPC"
}
