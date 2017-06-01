# simple-tf-demo
A simple terraform demo

## Usage ##
Prior to cloning this source code and running terraform plan or apply, you need to provide AWS credentials and the region
where you are are provisioning the infrastructure to the Terraform aws provider.

This can be done either by exporting them as environment variables in your shell e.g.
```
$ export AWS_DEFAULT_REGION=eu-west-2
$ export AWS_ACCESS_KEY_ID=xxxxx
$ export AWS_SECRET_ACCESS_KEY=xxxxx


$ git clone https://github.com/mjdilworth/simple-tf-app.git
$ cd app-server
$ terraform get
$ terraform plan
$ terraform apply
```
N.B - run terraform get with `-update` flag if you have made changes to `vpc` module after initial run.
OR

passing them as command line variables when running terraform plan or apply e.g.
```
$ git clone https://github.com/mjdilworth/simple-tf-app.git
$ cd app-server
$ terraform plan -var region=eu-west-1 -var access_key=xxxxx -var secret_key=xxxxx
$ terraform apply
```
There are other ways of providing AWS credentials for authentications - see [here](https://www.terraform.io/docs/providers/aws/#authentication)

## Access the Application ##
Open a web browser and go to this URL:
```
http://${elb_dns_name}:8080
```
