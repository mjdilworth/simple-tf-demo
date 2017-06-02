region = "eu-west-2"
region_az_number = 2
/* networking needs sorting out as its too large - use /24 for subnets and supernet these and only 2 for London */
vpc_cidr_block = "10.100.0.0/16"
public_subnet_cidr = ["10.100.0.0/20" ,"10.100.16.0/20","10.100.32.0/20"]
environment = "staging"
/* should set this to false or remove as defult is false */
associate_public_ip_address = "true"
ebs_optimized = "false"
instance_type = "t2.micro"
key_name = "mjd-key"
root_volume_size = "10"
force_delete = "false"
desired_capacity = 2
min_size = 2
max_size = 2
health_check_type = "EC2"
health_check_healthy_threshold = 2
health_check_unhealthy_threshold = 2
health_check_target = "HTTP:8484/"
health_check_interval = 15
health_check_timeout = 3
version = "1.8.1"
os = "linux"
arch = "amd64"
