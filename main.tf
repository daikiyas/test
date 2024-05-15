variable "access_key" {}             #アクセスキーの変数宣言
variable "secret_key" {}             #シークレットキーの変数宣言
variable "region" {                  #リージョンの変数宣言
  default = "ap-northeast-1"         #リージョンタイプ
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_security_group" "web-sg" {
    name = "web-sg"
    ingress {
    from_port = 8 // ICMP Type "Echo Request"
    to_port = 0 // ICMP Type "Echo Reply"
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web" {
    ami           = "ami-0d0150aa305b7226d"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.web-sg.name}"]
    tags = {
        Name = "ao-tanaka"                                   #ご自身の名前に変えてみましょう
    }
}
