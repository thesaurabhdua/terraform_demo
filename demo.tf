     provider "aws" {

         region                  = "us-west-2" 
         shared_credentials_file = "/home/saurabh/.aws"
         profile = "personal"
     
    }
    variable zones {
        default = ["us-west-2a","us-west-2b"]
    }
    
    resource aws_instance frontend {
        count = 2
        availability_zone = "${var.zones[count.index]}"
        ami = "ami-96207fee"
        instance_type = "t2.micro"    
        provider = "aws"
        lifecycle {
           create_before_destroy = true
        }
    }              
    
    resource aws_instance backend {
        count = 2
        availability_zone = "${var.zones[count.index]}"
        ami = "ami-96207fee"
        instance_type = "t2.micro"    
        provider = "aws"    
        lifecycle {
            prevent_destroy = false
        }
    }
    output "frontend_ip" {

        value = "${aws_instance.frontend.*.public_ip}"
    }
    output "backend_ip" {

        value = "${aws_instance.backend.*.public_ip}"
    }
