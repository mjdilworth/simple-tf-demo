module "vpc" {
  source             = "git::git@github.com:mjdilworth/tf-modules.git//modules//vpc?ref=v0.1"
  region             = "${var.region}"
  vpc_cidr_block     = "${var.vpc_cidr_block}"
  public_subnet_cidr = "${var.public_subnet_cidr}"
  name_tag           = "${var.environment}"
  number_public_subnets = "${var.region_az_number}"
}

resource "aws_launch_configuration" "lc" {

  lifecycle {
    create_before_destroy = true
  }

  name                        = "lc-${var.environment}"
  /* dont use public IP
  associate_public_ip_address = "${var.associate_public_ip_address}"*/
  ebs_optimized               = "${var.ebs_optimized}"
  image_id                    = "${data.aws_ami.rhel7_ami.id}"
  instance_type               = "${var.instance_type}"
  /* use without a key as i dont need to access the compute
  key_name                    = "${var.key_name}" */
  security_groups             = ["${aws_security_group.app_security_group.id}"]
  user_data                   = "${data.template_file.app_install.rendered}"

  root_block_device {
    volume_size = "${var.root_volume_size}"
  }
}

resource "aws_autoscaling_group" "asg" {
  lifecycle {
    create_before_destroy = true
  }

  name                 = "asg-${var.environment}"
  launch_configuration = "${aws_launch_configuration.lc.name}"

  vpc_zone_identifier = [
    "${module.vpc.public_subnet_ids}",
  ]

  force_delete     = "${var.force_delete}"
  desired_capacity = "${var.desired_capacity}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"

  load_balancers = [
    "${aws_elb.app_elb.name}",
  ]

  health_check_type = "${var.health_check_type}"

  tag {
    key                 = "Name"
    value               = "asg-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
