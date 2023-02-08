{% set securityGroupId = generateId('SecurityGroup_') %}
{% set vpcId = generateId('VPC_') %}
{% set internetGatewayId = generateId('InternetGateway_') %}
resource "aws_security_group" "{{securityGroupId}}" {
    vpc_id = ["{{vpcId}}"]
}

resource "aws_vpc" "{{vpcId}}" {
}

resource "aws_internet_gateway" "{{internetGatewayId}}" {
    vpc_id = "{{vpcId}}"
}
