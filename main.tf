provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "jenkins-ec2-instance"{
    ami = "ami-0cca134ec43cf708f" #Image id for the ap-south-1 region
    instance_type = "t2.micro"
}
