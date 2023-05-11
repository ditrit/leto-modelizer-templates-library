{% set securityGroupId = generateId('SecurityGroup', 'SecurityGroup_') %}
{% set vpcId = generateId('VPC', 'VPC_') %}
{% set internetGatewayId = generateId('InternetGateway', 'InternetGateway_') %}
resource "aws_security_group" "{{securityGroupId}}" {
    vpc_id = ["{{vpcId}}"]
}

resource "aws_vpc" "{{vpcId}}" {
}

resource "aws_internet_gateway" "{{internetGatewayId}}" {
    vpc_id = "{{vpcId}}"
}
