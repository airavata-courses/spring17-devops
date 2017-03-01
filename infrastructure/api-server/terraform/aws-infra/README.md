## Usage Instaructions:

1. Install Terraform, instructions [here](https://www.terraform.io/intro/getting-started/install.html)
2. Configure your AWS credentials in your system, instructions [here](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html)
3. Terraform automatically fetches the AWS credentials, if they are stored in default path ($HOME/.aws/credentials), or else refer this [document](https://www.terraform.io/docs/configuration/providers.html) to set up manually.
4. Set-up Terrraform to use Remote state, That is stored in S3 bucket, run this command "source remote-state-config" on linux/Mac OS or refer terraform docs for windows instructions.
5. You are set to go, you have the control over the infrastructure, to check run command "terraform plan".

Note: Be careful while changing any parameter.
